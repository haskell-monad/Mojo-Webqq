package Mojo::Webqq::Client;
use strict;
use Mojo::IOLoop;
$Mojo::Webqq::Client::CLIENT_COUNT  = 0;

use Mojo::Webqq::Client::Remote::_prepare_for_login;
use Mojo::Webqq::Client::Remote::_check_verify_code;
use Mojo::Webqq::Client::Remote::_get_img_verify_code;
use Mojo::Webqq::Client::Remote::_get_qrlogin_pic;
use Mojo::Webqq::Client::Remote::_login1;
use Mojo::Webqq::Client::Remote::_check_sig;
use Mojo::Webqq::Client::Remote::_login2;
use Mojo::Webqq::Client::Remote::_get_vfwebqq;
use Mojo::Webqq::Client::Remote::_cookie_proxy;
use Mojo::Webqq::Client::Remote::change_state;
use Mojo::Webqq::Client::Remote::_get_offpic;
use Mojo::Webqq::Client::Remote::_get_group_pic;
use Mojo::Webqq::Client::Remote::_recv_message;
use Mojo::Webqq::Client::Remote::_relink;
use Mojo::Webqq::Client::Remote::logout;

use base qw(Mojo::Webqq::Request Mojo::Webqq::Client::Cron);

sub run{
    my $self = shift;
    $self->ready();
    $self->emit("run");
    $self->ioloop->start unless $self->ioloop->is_running;
}

sub multi_run{
    Mojo::IOLoop->singleton->start unless Mojo::IOLoop->singleton->is_running; 
}
sub stop{
    my $self = shift;
    my $mode = shift || "auto";
    $self->is_stop(1);
    if($mode eq "auto"){
        $Mojo::Webqq::Client::CLIENT_COUNT > 1?$Mojo::Webqq::Client::CLIENT_COUNT--:exit;
    }
    else{
        $Mojo::Webqq::Client::CLIENT_COUNT--;
    }
}
sub exit{
    my $self = shift;  
    my $code = shift;
    exit(defined $code?$code+0:0);
}
sub ready{
    my $self = shift;
    #加载插件
    my $plugins = $self->plugins;
    for(
        sort {$plugins->{$b}{priority} <=> $plugins->{$a}{priority} } 
        grep {defined $plugins->{$_}{auto_call} and $plugins->{$_}{auto_call} == 1} keys %{$plugins}
    ){
        $self->call($_);
    }
    $self->emit("after_load_plugin");

    $self->relogin() if $self->get_model_status() == 0;

    $self->on(send_message=>sub{
        my($self,$msg)=@_;
        return unless $msg->type =~/^message|sess_message$/;
        $self->add_recent($msg->receiver);
    });
    $self->on(receive_message=>sub{
        my($self,$msg)=@_;
        return unless $msg->type =~/^message|sess_message$/;
        my $sender_id = $msg->sender->id;
        $self->add_recent($msg->sender);
        unless(exists $self->data->{first_talk}{$sender_id}) {
            $self->data->{first_talk}{$sender_id}++;
            $self->emit(first_talk=>$msg->sender,$msg);
        }
    });   
    $self->interval(3600*4,sub{$self->data(+{})});
    $self->interval(300,sub{
        return if ref $self ne 'Mojo::Webqq';
        $self->debug("检查数据完整性...");
        for my $g ($self->groups){
            if(not defined $g->{_client}){
                $g->{_client} = $self;
                $self->warn("群对象(" . $g->gid . ")数据异常, 已尝试修复");
            }
            for my $m ($g->members){
                if(not defined $m->{_client}){
                    $m->{_client} = $self;
                    $self->warn("群成员对象(". $m->id . ")数据异常, 已尝试修复");
                }
            }
        } 
        for my $d ($self->discusss){
            if(not defined $d->{_client}){
                $d->{_client} = $self;
                $self->warn("讨论组对象(" . $d->did . ")数据异常, 已尝试修复");
            }
            for my $m ($d->members){
                if(not defined $m->{_client}){
                    $m->{_client} = $self;
                    $self->warn("讨论组成员对象(". $m->id . ")数据异常, 已尝试修复");
                }
            }
        }
        for my $f ($self->friends){
            if(not defined $f->{_client}){
                $f->{_client} = $self;
                $self->warn("好友对象(" . $f->id . ")数据异常, 已尝试修复");
            }
        }        
    });
    $self->interval(600,sub{
        return if $self->is_stop;
        $self->update_group;
    });

    $self->timer(60,sub{
        $self->interval(600,sub{
            return if $self->is_stop;
            $self->update_discuss;    
        });
    });

    $self->timer(60+60,sub{
        $self->interval(600,sub{
            return if $self->is_stop;
            $self->update_friend;
        });
    });
    #接收消息
    $self->on(poll_over=>sub{ my $self = $_[0];$self->timer(1,sub{$self->_recv_message()}) } );
    $self->info("开始接收消息...\n");
    $self->_recv_message();
    $Mojo::Webqq::Client::CLIENT_COUNT++;
    $self->emit("ready");
}

sub timer {
    my $self = shift;
    $self->ioloop->timer(@_);
    return $self;
}
sub interval{
    my $self = shift;
    $self->ioloop->recurring(@_);
    return $self;
}
sub relogin{
    my $self = shift;
    $self->info("正在重新登录...\n");
    $self->logout();
    $self->login_state("relogin");
    $self->sess_sig_cache(Mojo::Webqq::Cache->new);
    $self->id_to_qq_cache(Mojo::Webqq::Cache->new);
    $self->ua->cookie_jar->empty;
    $self->poll_failure_count(0);
    $self->csrf_token(undef);
    $self->model_ext(0);

    $self->user(+{});
    $self->friend([]);
    $self->group([]);
    $self->discuss([]);
    $self->recent([]);
    $self->data(+{});
    $self->model_status(+{});

    $self->login(delay=>0);
    $self->emit("relogin");
}
sub relink {
    my $self = shift;
    $self->info("尝试进行重新连接(1)...");
    if($self->_get_vfwebqq() && $self->_login2()){
        $self->info("重新连接(1)成功");
    }
    else{
        $self->info("重新连接(1)失败");
        $self->relogin();
    }
}
sub login {
    my $self = shift;
    my %p = @_;
    $self->qq($p{qq}) if defined $p{qq};
    $self->pwd($p{pwd}) if defined $p{pwd};
    my $delay = defined $p{delay}?$p{delay}:0;
    if($self->is_first_login == -1){
        $self->is_first_login(1);
    }
    elsif($self->is_first_login == 1){
        $self->is_first_login(0);
    }
    my $callback = sub{
        if($self->is_first_login){
            $self->load_cookie();
            my $ptwebqq = $self->search_cookie("ptwebqq");
            my $skey = $self->search_cookie("skey");
            $self->ptwebqq($ptwebqq) if defined $ptwebqq;
            $self->skey($skey) if defined $skey;
        }
        if(defined $self->ptwebqq and defined $self->skey){
            $self->info("检测到最近登录活动，尝试直接恢复登录...");
            $self->relogin() if not $self->_get_vfwebqq() && $self->_login2();
        } 
        elsif(
            $self->_prepare_for_login()    
            && $self->_check_verify_code()     
            && $self->_get_img_verify_code()
            && $self->_get_qrlogin_pic()

        ){
            while(1){
                my $ret = $self->_login1();
                if($ret == -1){#验证码输入错误
                    $self->_get_img_verify_code();
                    next;
                }
                elsif($ret == -2){#帐号或密码错误
                    $self->error("登录失败，尝试更换加密算法计算方式，重新登录...");
                    $self->encrypt_method("js");
                    $self->relogin();
                    return;
                }
                elsif($ret == -4 ){#等待二维码扫描
                    sleep 3;
                    next;
                }
                elsif($ret == -5 ){#二维码已经扫描 等待手机端进行授权登录
                    sleep 3;
                    next;
                }
                elsif($ret == -6){#二维码已经过期，重新下载二维码
                    $self->_get_qrlogin_pic();
                    next;
                }
                elsif($ret == 1){#登录成功
                    $self->_check_sig() 
                    && $self->_get_vfwebqq()
                    && $self->_login2();
                    last;
                }
                else{
                    last;
                }
            }
        }

        #登录不成功，客户端退出运行
        if($self->login_state ne 'success'){
            $self->fatal("登录失败，客户端退出（可能网络不稳定，请多尝试几次）");
            $self->stop();
        }
        else{
            $self->info("帐号(" . $self->qq . ")登录成功");
            $self->update_user;
            $self->update_friend;
            $self->update_group;
            $self->update_discuss;
            $self->update_recent;
            $self->emit("login");
        }
    };
    $delay?$self->on(after_load_plugin=>$callback):$callback->();
    return $self;
}

sub mail{
    my $self  = shift;
    my $callback ;
    my $is_blocking = 1;
    if(ref $_[-1] eq "CODE"){
        $callback = pop;
        $is_blocking = 0;
    }
    my %opt = @_;
    #smtp
    #port
    #tls
    #tls_ca
    #tls_cert
    #tls_key
    #user
    #pass
    #from
    #to
    #cc
    #subject
    #charset
    #html
    #text
    #data MIME::Lite产生的发送数据
    eval{ require Mojo::SMTP::Client; } ;
    if($@){
        $self->error("发送邮件，请先安装模块 Mojo::SMTP::Client");
        return;
    }
    my @new = (
        address => $opt{smtp},
        port    => $opt{port} || 25,
        autodie => $is_blocking,
    ); 
    for(qw(tls tls_ca tls_cert tls_key)){
        push @new, ($_,$opt{$_}) if defined $opt{$_}; 
    }
    my $smtp = Mojo::SMTP::Client->new(@new);
    unless(defined $smtp){
        $self->error("Mojo::SMTP::Client客户端初始化失败");
        return;
    }
    my $data;
    if(defined $opt{data}){$data = $opt{data}}
    else{
        my @data;
        push @data,("From: $opt{from}","To: $opt{to}");
        push @data,"Cc: $opt{cc}" if defined $opt{cc};
        require MIME::Base64;
        my $charset = defined $opt{charset}?$opt{charset}:"UTF-8";
        push @data,"Subject: =?$charset?B?" . MIME::Base64::encode_base64($opt{subject},"") . "?=";
        if(defined $opt{text}){
            push @data,("Content-Type: text/plain; charset=$charset",'',$opt{text});
        }
        elsif(defined $opt{html}){
            push @data,("Content-Type: text/html; charset=$charset",'',$opt{html});
        }
        $data = join "\r\n",@data;
    }
    if(defined $callback){#non-blocking send
        $smtp->send(
            auth    => {login=>$opt{user},password=>$opt{pass}},
            from    => $opt{from},
            to      => $opt{to},
            data    => $data,
            quit    => 1,
            sub{
                my ($smtp, $resp) = @_;
                if($resp->error){
                    $self->error("邮件[ To: $opt{to}|Subject: $opt{subject} ]发送失败: " . $resp->error );
                    $callback->(0,$resp->error) if ref $callback eq "CODE"; 
                    return;
                }
                else{
                    $self->debug("邮件[ To: $opt{to}|Subject: $opt{subject} ]发送成功");
                    $callback->(1) if ref $callback eq "CODE";
                }
            },
        );
    }
    else{#blocking send
        eval{
            $smtp->send(
                auth    => {login=>$opt{user},password=>$opt{pass}},
                from    => $opt{from},
                to      => $opt{to},
                data    => $data,
                quit    => 1,
            );
        };
        return $@?(0,$@):(1,);
    }
    
}

sub spawn {
    my $self = shift;
    my %opt = @_;
    require Mojo::Webqq::Run;
    my $run = Mojo::Webqq::Run->new(ioloop=>$self->ioloop,log=>$self->log); 
    $run->max_forks(delete $opt{max_forks}) if defined $opt{max_forks};
    $run->spawn(%opt);
    $run;
}
sub clean_qrcode{
    my $self = shift;
    return if not defined $self->qrcode_path;
    return if not -f $self->qrcode_path;
    $self->info("清除残留的历史二维码图片");
    unlink $self->qrcode_path or $self->warn("删除二维码图片[ " . $self->qrcode_path . " ]失败: $!");
}
sub clean_verifycode{
    my $self = shift;
    return if not defined $self->verifycode_path;
    return if not -f $self->verifycode_path;
    $self->info("清除残留的历史验证码图片");
    unlink $self->verifycode_path or $self->warn("删除验证码图片[ ". $self->verifycode_path . " ]失败: $!");
}
1;
