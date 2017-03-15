package Mojo::Webqq::Plugin::SmartReply;
$Mojo::Webqq::Plugin::SmartReply::PRIORITY = 97;
=start
你好，你是美女么？	挖掘机技术哪家强？
讲个笑话	冷笑话
刘亦菲的图片
北京今天的天气	北京今天的空气质量
地球到月球的距离	感冒怎么办	虎皮鹦鹉吃什么
百科周杰伦	李连杰的介绍
讲个故事	讲个白雪公主的故事
我要看新闻	体育新闻	科技新闻	周杰伦的新闻
红烧肉怎么做	辣子鸡丁的菜谱
天蝎座明天的运势	现在是什么星座	今年属牛的运势
解梦：梦到桃花怎么回事	周杰伦这个名字好不好	10086凶吉
开始成语接龙
顺丰快递
明天从北京到上海的航班
明天从北京到石家庄的火车
3乘以5等于多少
25*25等多少
=cut
use POSIX;
use Encode;
my $api = 'http://www.tuling123.com/openapi/api';
my %limit;
my %ban;
my @limit_reply = (
    "对不起，请不要这么频繁的艾特我",
    "对不起，您的艾特次数太多",
    "说这么多话不累么，请休息几分钟",
    "能不能小窗我啊，别吵着大家",
);
sub call{
    my $client = shift;
    my $data   = shift;
    $client->interval(600,sub{
        my $key = strftime("%H:%M",localtime(time-600));
        delete $limit{$key};
    });
    $client->on(receive_message=>sub{
        my($client,$msg) = @_;
        #return if not $msg->allow_plugin;
        return if $msg->type !~ /^message|group_message|sess_message$/;
        return if exists $ban{$msg->sender->id};
        my $sender_nick = $msg->sender->displayname;
        my $user_nick = $msg->receiver->displayname;
        return if $msg->type eq "group_message" and !$msg->is_at;

        $msg->allow_plugin(0);
        if($msg->type eq 'group_message'){
            my $key = POSIX::strftime("%H",localtime(time));
            $limit{$key}{$msg->group->gid}{$msg->sender->id}++; 
            my $limit  = $limit{$key}{$msg->group->gid}{$msg->sender->id};
            if($limit>=24 and $limit<=25){
                $client->reply_message($msg,"\@$sender_nick " . $limit_reply[int rand($#limit_reply+1)],sub{$_[1]->msg_from("bot")});
                return;
            }   
            if($limit >=26 and $limit <=30){
                $client->reply_message($msg,"\@$sender_nick " . "警告，您艾特过于频繁，即将被列入黑名单，请克制",sub{$_[1]->msg_from("bot")});
                return;
            }
            if($limit > 30){
                $ban{$msg->sender->id} = 1;
                $client->reply_message($msg,"\@$sender_nick " . "您已被列入黑名单，1小时内提问无视",sub{$_[1]->msg_from("bot")});
                $client->timer(3600,sub{delete $ban{$msg->sender->id};});
            }
        } 

        my $input = $msg->content;
        $input=~s/\@\Q$user_nick\E ?|\[[^\[\]]+\]\x01|\[[^\[\]]+\]//g;
        return unless $input;
		#4c53b48522ac4efdfe5dfb4f6149ae51
        my @query_string = (
            "key"       =>  $data->{apikey} || "ea015e678b3855ebbef9e1ebcb40fd80",
            "userid"    =>  $msg->sender->id,
            "info"      =>  decode("utf8",$input),
        );

        push @query_string,(loc=>$msg->sender->city."市") if $msg->type eq "group_message" and  $msg->sender->city; 
        $client->http_get($api,{json=>1},form=>{@query_string},sub{
            my $json = shift;
            return unless defined $json;
            return if $json->{code}=~/^4000[1-7]$/;
            my $reply;
            if($json->{code} == 100000){#你好
                return unless $json->{text};
                $reply = encode("utf8",$json->{text});
            }elsif($json->{code} == 200000){#小狗的图片
                $reply = encode("utf8","$json->{text}$json->{url}");
            }elsif($json->{code} == 302000 || $json->{code} == 308000){#我想看新闻,鱼香肉丝怎么做#http://www.tuling123.com/plugin/proexp.html
				my $array = $json->{list};
				if(scalar(@$array) > 0){
					$reply .= "$item->{text}\n";
					foreach my $item (@$array) {
						$reply .= "$item->{detailurl}\n";
					}
				}
			}else{return}

            $reply  = "\@$sender_nick " . $reply  if $msg->type eq 'group_message' and rand(100)>20;
            $reply = $client->truncate($reply,max_bytes=>500,max_lines=>10) if $msg->type eq 'group_message';        
            $client->reply_message($msg,$reply,sub{$_[1]->msg_from("bot")}) if $reply;
        });

    }); 
}

1;
