package Mojo::Webqq::Plugin::KnowledgeBase;
$Mojo::Webqq::Plugin::KnowledgeBase::PRIORITY = 2;

use Storable qw(retrieve nstore);
sub call{
    my $client = shift;
    my $data = shift;
    my $file = $data->{file} || './KnowledgeBase.dat';
    my $base = {};
    $base = retrieve($file) if -e $file;
    #$client->timer(120,sub{nstore $base,$file});
    my $callback = sub{
        my($client,$msg) = @_;
        return if $msg->type !~ /^message|group_message|dicsuss_message|sess_message$/;
        if($msg->content =~ /^(?:learn|学习)
                            \s+
                            (?|"([^"]+)"|'([^']+)'|([^\s"']+))
                            \s+
                            (?|"([^"]+)"|'([^']+)'|([^\s"']+))
                            /xs){
            $msg->allow_plugin(0);
            my($q,$a) = ($1,$2);
            return unless defined $q;
            return unless defined $a;
            $q=~s/^\s+|\s+$//g;
            $a=~s/^\s+|\s+$//g;
            push @{ $base->{$q} }, $a;
            nstore($base,$file);
            $client->reply_message($msg,"知识库[ $q -> $a ]添加成功",sub{$_[1]->msg_from("bot")}); 
        }   
        elsif($msg->content =~ /^(?:del|delete|删除)
                            \s+
                            (?|"([^"]+)"|'([^']+)'|([^\s"']+))
                            /xs){
            $msg->allow_plugin(0);
            #return if $msg->sender->id ne $client->user->id;
            my($q) = ($1);
            $q=~s/^\s+|\s+$//g;
            return unless defined $q;
            delete $base->{$q}; 
            nstore($base,$file);
            $client->reply_message($msg,"知识库[ $q ]删除成功"),sub{$_[1]->msg_from("bot")};
        }
		elsif ($msg->content =~ /^知识库\s+/g) {
			$msg->allow_plugin(0);
			my $content = $msg->content;
			$content =~ s/知识库//g;
			return unless defined $content;
            $content=~s/^\s+|\s+$//g;
			my $sender_nick = $msg->sender->displayname;
			my @array = grep ($_ =~ /$content/,(keys %$base));
			my $reply = join("|",@array);
			return unless defined $reply;
			$client->reply_message($msg,"\@$sender_nick 亲,知识库中目前存在<".scalar(@array).">条关于<$content>的记录:\n$reply"),sub{$_[1]->msg_from("bot")};
		}
		elsif ($msg->content =~ /^大话西游/g) {
			my $reply;
			my $flag = 1;
			while (<DATA>) {
				 $reply .= $_;
				 if ($flag % 5 == 0) {
					 $client->reply_message($msg,$reply),sub{$_[1]->msg_from("bot")};
					 $reply=undef;
				 }
				 $flag++;
			}
		}
        else{
            return if $msg->msg_class eq "send" and $msg->msg_from ne "api" and $msg->msg_from ne "irc";
            my $content = $msg->content;
            $content =~s/^[a-zA-Z0-9_]+: ?// if $msg->msg_from eq "irc";
            return unless exists $base->{$content};
            $msg->allow_plugin(0);
            my $len = @{$base->{$content}};
            $client->reply_message($msg,$base->{$content}->[int rand $len],sub{$_[1]->msg_from("bot")});
        }
    };
    $client->on(receive_message=>$callback);
    $client->on(send_message=>$callback);
}
1;

__DATA__
书香门第逍遥生
洛水之崖猛壮士
且试天下飞剑侠
长河落日剑侠客
不让须眉英女侠
刁蛮任性飞燕女
扰抱琵琶俏千金
奈何关外天山雪
雪海深愁暗神伤
西游路上莫彷徨
古往今来英雄路
何人无愁肠
男儿当自强
法术失心狂
奈何烟花多寂寞
怎能不惆怅
女儿多柔情
本是不想争
奈何毒法力微薄
何处求杀伤
男仙很风狂
袖里乾坤藏
奈何抗性实在差
轻轻就混上
女仙也彷徨
抗议跟不上
奈何仙族都一样
混乱真是强
女魔很忧伤
速度要跟上
奈何若是出手慢
都要被冰上
男魔更忧伤
速度也很强
奈何处处被遗忘
谁怜男魔伤
貌似很风光
男鬼也悲怆
奈何高端女吃香
三尸扶山岗
女鬼艳无双
升级路漫长
奈何魅惑很奇妙
经常用不上
唉……
谁之伤
谁之伤
一曲销魂解愁肠
自古英雄多寂寞
终有一朝称霸王