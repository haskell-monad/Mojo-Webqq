package Mojo::Webqq::Plugin::QQMsgSync;
$Mojo::Webqq::Plugin::QQMsgSync::PRIORITY = 98;
use strict;
use Encode;
use List::Util qw(first);


=cut
	usage:
		$client->load("QQMsgSync",data=>{
			pairs=>[
				[$client->search_group(gname=>"烟雨江南"),$client->search_group(gname=>"天涯海阁")],
				[$client->search_group(gname=>"北京Java招聘"),$client->search_group(gname=>"天涯海阁")]
			]
		});
=cut
my @pairs;#([{type=>"group",name=>PERL学习交流},{type=>"group",name=>天涯海阁}],[{type=>"group",name=>PERL学习交流},{type=>"group",name=>天涯海阁}])
my %group_status;
my %irc_channel_status;
my $irc = undef;
sub call{
    my $client = shift;
    my $data = shift;
    return if ref $data ne "HASH";
    return if ref $data->{pairs} ne "ARRAY";
    for my $pair (@{ $data->{pairs} }){
        my @p;
        for(@{$pair}){
            if((ref $_) eq "Mojo::Webqq::Group"){
                push @p,{type=>"group",name=>$_->gname} ;
                $group_status{$_->gname}=1;
            }
        }
        push @pairs,\@p;
    }
    my $callback = sub{
        my ($client,$msg)=@_;
		#$client->debug("msg_class: ".($msg->msg_class));
		#$client->debug("msg_from: ".($msg->msg_from));
        return if $msg->msg_class eq "send" and $msg->msg_from eq "bot"; 
        return if $msg->type ne 'group_message';
        my $sender_nick;
        if($msg->msg_class eq "recv"){
            $sender_nick = $msg->sender->card || $msg->sender->nick; #消息发送者(消息来源)
        }elsif($msg->msg_class eq "send"){ #消息接受者(消息去向)
            if($msg->msg_from eq "bot"){
                $sender_nick = "助理";
            }else{
				$sender_nick = $msg->sender->nick;
			}
        }
		#$client->debug("sender_nick: ".$sender_nick);
		my $gname = $msg->group->gname;
        return unless first {$gname eq $_} keys %group_status;
        for my $pair (@pairs){ 
            next unless first {$_->{type} eq "group" and $_->{name} eq $gname} @$pair;
            for(grep {$_->{type} eq "group" and $_->{name} ne $gname} @$pair){
                my $g = $client->search_group(gname=>$_->{name});
                next unless defined $g;
				next unless $msg->content !~ /^[qQ]+:\d+$/g;
				next unless $msg->content !~ /文曲|星君|刷手|刷单|扫码|打码|傻逼|操|艹|尼玛|你妈|大爷|玩意|滚|垃圾|逗比|踢|日/g;
                $client->send_group_message($g,"${sender_nick}|$gname: " . $msg->content,sub{
					$_[1]->msg_from("bot");
					$_[1]->cb(sub{
						my($client,$msg,$status)=@_;
						return if $status->is_success;
					});
				});
            }
        }
    };
    $client->on(receive_message=>$callback,send_message=>$callback);
}
1;