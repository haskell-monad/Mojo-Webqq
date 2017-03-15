package Mojo::Webqq::Plugin::Questions;
$Mojo::Webqq::Plugin::Questions::PRIORITY = 98;
use Encode;
=cut
	QQ群争霸赛
	usage:
		题库 --help
		题库|出题|[回答时间:10秒]|[群众帮忙次数:默认1次]
			随机发送一个题目，”夸奖“第一个答对的。不记录。
		题库|[求助|help]
			求助群好友，只选择第一个回答的，此时表暂停。
			群好友回答方式,只有此格式有效：
				[求助|help]>>>问题答案
		题库|[个人sa|对战]|[科目:默认随机]|[难易程度:简单、中等、困难]|[题目数量:默认10道]|[出题间隔:默认10秒]|每题分数:默认5分|报名人数:默认100人
			记录每道题的第一个答对的.统计周冠军、月冠军、季度冠军、年冠军，会扣除败者少量的分数添加给胜利者
		题库|极限|[竞赛|个人]|[科目:默认随机]|[题目数量:默认15道]|[出题间隔:默认5秒]|每题分数:默认10分|报名人数:默认10人
			送称号、送权限、送女友，会扣除败者超级多的分数添加给胜利者
		题库|[个人sa|对战vs]|排名|[正序|倒叙]|[top N:默认10]
			打印排行榜，比赛中不可用
		题库|[科目|sub]
			打印科目列表，比赛中不可用
		题库|[比分|score]
			打印当前正在比赛的比分
		题库|[放弃|cancel]
			放弃本次比赛
		题库|[跳过|skip]
			跳过本次答题,个人版跳过本题，对战版需要一半以上的人跳过才算跳过
		题库|[报名|join]
			机器人发出题目信息一段时间后，可以报名参加本次比赛
		题库|[模式|model]
			打印当前比赛的模式
		题库|[人数|number]
			打印当前参数的人数
		题库|[明星|star]
			打印当前明星级别的参赛者，仅对战版有效
		题库|[人气|fans]
			打印当前的人气粉丝最旺的参赛者，仅对战版有效
		题库|[历史|history]
			打印最近一次比赛的信息
=cut
my %hash = (
	"圆通" => "yuantong",
	"韵达" => "yunda",
	"申通" => "shentong",
	"百世汇通" => "huitongkuaidi",
	"天天" => "tiantian",
	"中通" => "zhongtong",
	"顺丰" => "shunfeng",
	"EMS" => "ems",
	"宅急送" => "zhaijisong",
	"全峰" => "quanfengkuaidi",
	"邮政国内" => "youzhengguonei",
	"邮政国际" => "youzhengguoji"
);
my $api = "http://www.kuaidi100.com/query?valicode=&temp=0.08478904655203223&id=1";
sub call{
    my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		my $sender_nick = $msg->sender->displayname;
		my $reply;
		if ($msg->{content} =~ m/^快递\|([^\s]+)\s+([A-Za-z0-9]+)/g) {
			$msg->allow_plugin(0);
			my $china = $1;
			my $postid = $2;
			$china=~s/^\s+|\s+$//g;
			$postid=~s/^\s+|\s+$//g;
			$type = $hash{$china};
			unless ($type) {
				$client->reply_message($msg,"\@$sender_nick 暂时不支持$china");
				return;
			}
			return unless $postid;
			$client->http_get("$api&type=$type&postid=$postid",{json=>1},sub{
				my $data = shift;
				return unless defined $data;
				#{"status":"201","message":"快递公司参数异常：单号不存在或者已经过期"}
				#{"nu":"700074134800","message":"ok","ischeck":"0","com":"yuantong","updatetime":"2015-11-24 11:50:10","status":"200","condition":"00","data":[{"time":"2015-11-18 21:18:01","context":"北京市海淀区学清路公司 已收入","ftime":"2015-11-18 21:18:01"},{"time":"2015-11-18 10:01:23","context":"北京转运中心 已发出,下一站 北京市海淀区学清路","ftime":"2015-11-18 10:01:23"},{"time":"2015-11-18 09:59:05","context":"北京转运中心 已拆包","ftime":"2015-11-18 09:59:05"},{"time":"2015-11-18 09:26:46","context":"北京转运中心 已收入","ftime":"2015-11-18 09:26:46"},{"time":"2015-11-17 02:17:55","context":"郑州转运中心 已发出,下一站 北京转运中心","ftime":"2015-11-17 02:17:55"},{"time":"2015-11-17 02:17:49","context":"郑州转运中心 已收入","ftime":"2015-11-17 02:17:49"},{"time":"2015-11-16 23:35:13","context":"河南省郑州市中原区公司 已发出,下一站 郑州转运中心","ftime":"2015-11-16 23:35:13"},{"time":"2015-11-14 00:39:49","context":"虎门转运中心 已发出,下一站 北京转运中心","ftime":"2015-11-14 00:39:49"},{"time":"2015-11-14 00:10:34","context":"虎门转运中心 已收入","ftime":"2015-11-14 00:10:34"},{"time":"2015-11-13 22:49:28","context":"广东省东莞市新东城公司 已发出,下一站 虎门转运中心","ftime":"2015-11-13 22:49:28"},{"time":"2015-11-13 19:36:20","context":"广东省东莞市新东城公司 已打包","ftime":"2015-11-13 19:36:20"},{"time":"2015-11-13 12:08:51","context":"广东省东莞市新东城公司(点击查询电话) 已揽收","ftime":"2015-11-13 12:08:51"}],"state":"0"}
				my $code = $data->{status};
				my $reply;
				if ($code == 200) {
					if (ref($data->{data}) eq 'ARRAY') {
						my $array = $data->{data};
						my $size = scalar(@$array);
						$reply .= "查询到订单 “$china $postid” 有 $size 条信息:\n---------------------------------\n";
						if (scalar($array) > 0) {
							foreach $msg (@$array) {
								if (ref($msg) eq "HASH") {
									$client->debug($msg->{ftime});
									$reply .= ($msg->{ftime})."\n".(encode("utf8",$msg->{context}))."\n";
								}
							}
							$reply .= "---------------------------------";
						}
					}else{
						$reply = "没有找到订单 “$postid” 的相关信息.";
					}
				}else{
					$reply = $data->{message};
				}
				$client->reply_message($msg,"\@$sender_nick\n $reply");
			});
		}elsif ($msg->{content} =~ m/^快递\s+--h/g) {
			$msg->allow_plugin(0);
			$reply = "\@$sender_nick 目前支持以下快递信息的查询:\n";
			$reply .= join(" ",keys %hash);
			$reply .= "\n您可以使用: 快递|快递名称 快递单号 进行查询快递信息.\n如:快递|圆通 700074134800";
			$client->reply_message($msg,"$reply");
		}else{
			return;
		}
	});
}
1;