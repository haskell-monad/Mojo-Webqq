package Mojo::Webqq::Plugin::Express;
$Mojo::Webqq::Plugin::Express::PRIORITY = 98;
use Encode;
=cut
	usage:
		快递 --h
		快递|圆通 700074134800
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
		if ($msg->content =~ m/^快递\|([^\s]+)\s+([A-Za-z0-9]+)/g) {
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
			$api .= "&type=$type&postid=$postid";
			$client->debug("=============================".$api);
			$client->http_get($api,{json=>1},sub{
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
					#$reply = $data->{message};
					$reply .= encode("utf8",$data->{message});
					$client->debug("error info: ".$reply);
				}
				if(count_lines($reply) > 12){
					#$reply  = join "\n",(split /\r?\n/,$reply,17)[0..15];
					#$reply .= "\n------------------------------------------------(已截断)";
					my @aa = (split /\r?\n/,$reply,13)[0..11];
					$client->reply_message($msg,"\@$sender_nick");
					foreach my $i (@aa) {
						$client->reply_message($msg,$i);
					}
				}else{
					$client->reply_message($msg,"\@$sender_nick\n $reply");
				}
			});
		}elsif ($msg->content =~ m/^快递\s+--h/g) {
			$msg->allow_plugin(0);
			$reply = "\@$sender_nick 目前支持以下快递信息的查询:\n";
			$reply .= join(" ",keys %hash);
			$reply .= "\n您可以使用: 快递|快递名称 快递单号 进行查询快递信息.\n如:快递|圆通 700074134800";
			$client->reply_message($msg,$reply);
		}else{
			return;
		}
	});
}
1;

sub count_lines{
    my $data = shift;
    my $count =()=$data=~/\r?\n/g;
    return $count++;
}