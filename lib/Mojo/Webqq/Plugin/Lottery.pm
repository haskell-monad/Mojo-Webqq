package Mojo::Webqq::Plugin::Lottery;
$Mojo::Webqq::Plugin::Lottery::PRIORITY = 99;
use POSIX qw(strftime);
use Encode;
=cut
	usage:
		彩票 -l
		彩票 双色球
=cut

my %hash = ();
my $api_list = "http://apis.baidu.com/apistore/lottery/lotterylist";
my $api_detail = "http://apis.baidu.com/apistore/lottery/lotteryquery";
sub call{
	my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		my $content = $msg->content;
		if ($content =~ m#^彩票\s+#) {
			$msg->allow_plugin(0);
			my $sender_nick = $msg->sender->displayname;
			$content=~s/彩票//g;
			$content=~s/^\s+|\s+$//g;
			my $reply;
			if (scalar(keys %hash) < 1) {
				my $data_list = $client->http_get($api_list,{json=>1,retry_times=>2,apikey=>"f23168e0956fe11f6fc44ee61dbfa002"},form=>{lotterytype=>1});
				if ($data_list->{errNum} == 0) {
					my $length = scalar(@{$data_list->{retData}});
					if ($length > 0) {
						for (0..$length) {
							$hash{encode("utf8",$data_list->{retData}->[$_]->{lotteryName})}=$data_list->{retData}->[$_]->{lotteryCode};
						}
					}else{
						$client->debug("获取彩票列表出错(".$data_list->{errNum}.")");
						return;
					}
				}
			}
			if ($content eq '-l' || $content eq '-h') {
				$reply = join("|",keys %hash);
				$client->reply_message($msg,"\@$sender_nick 亲, 目前仅支持如下彩票(来自 如来助理):\n$reply\n您可以使用:“彩票 XX”来查询，如查询双色球输入: 彩票 双色球");	
				return;
			}
			my $code;
			if (exists $hash{$content}) {
				$code = $hash{$content};
			}else{
				$reply = join("|",keys %hash);
				$client->reply_message($msg,"\@$sender_nick 亲, 目前仅支持如下彩票(来自 如来助理):\n$reply\n您可以使用:“彩票 XX”来查询，如查询双色球输入: 彩票 双色球");	
				return;			
			}
			return unless defined $code;
			$client->http_get($api_detail,{json=>1,apikey=>"f23168e0956fe11f6fc44ee61dbfa002"},form=>{lotterycode=>$code,recordcnt=>1},sub{
				my $data = shift;
				return unless defined $data;
				if ($data->{errNum} == 0) {
					my $expect = $data->{retData}->{data}->[0]->{expect};
					my $result = $data->{retData}->{data}->[0]->{openCode};
					my $date = $data->{retData}->{data}->[0]->{openTime};
					return unless defined $expect;
					$reply = "$content 第 $expect 期\n";
					$reply .= "开奖结果: $result\n";
					$reply .= "开奖日期: $date";
					$client->reply_message($msg,"\@$sender_nick 亲,已为您找到彩票“$content”最近一期开奖结果(来自 如来助理)\n$reply");
				}else{
					$client->debug("彩票 fail(".$data->{errNum}.")");
					$client->reply_message($msg,"\@$sender_nick 亲,彩票“$content”查询出错，请再多尝试几次(来自 如来助理)");
				}
			});
		}
    });
}
1;