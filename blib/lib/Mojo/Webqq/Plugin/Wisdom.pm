package Mojo::Webqq::Plugin::Wisdom;
$Mojo::Webqq::Plugin::Wisdom::PRIORITY = 99;
use Encode;
=cut
	名人名言
	usage:
		名人名言 "关键字"
		名人名言 "关键字"
		名人名言 "关键字"
=cut
sub call{
	my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		my $content = $msg->content;
		if ($content =~ m#^名人名言\s+"([^"]+)"$#) {
			$msg->allow_plugin(0);
			my $sender_nick = $msg->sender->displayname;
			my $keyword = $1;
			$keyword=~s/^\s+|\s+$//g;
			return unless defined $keyword;
	
			my $page = ((int rand 10) + 1);#第几页
			my $which = ((int rand 18) + 1);#第几条
			$client->debug("获取名人名言:($keyword)(第 $page 页) 的 (第 $which 条)");
			my $reply;
			my $ url = "http://apis.baidu.com/avatardata/mingrenmingyan/lookup";
			$client->http_get($url,{json=>1,apikey=>"f23168e0956fe11f6fc44ee61dbfa002"},form=>{dtype=>"json",page=>$page,rows=>20,keyword=>decode("utf8",$keyword)},sub{
				my $data = shift;
				return unless defined $data;
				if ($data->{reason} eq 'Succes') {
					$reply = encode("utf8",$data->{result}->[$which]->{famous_saying});
					unless (defined $reply) {
						$client->reply_message($msg,"\@$sender_nick 亲,该页没有关于“$keyword”的名人名言数据,请再多尝试几下(来自 如来助理)");
						return;
					}
					$reply .= "(出自 ".encode("utf8",$data->{result}->[$which]->{famous_name}).")";
					$client->reply_message($msg,"\@$sender_nick 亲,已为您找到关于“$keyword”的名人名言(来自 如来助理)\n$reply");
				}else{
					$client->debug("名人名言fail: ".encode("utf8",$data->{reason}));
					$client->reply_message($msg,"\@$sender_nick 亲,没有找到关于“$keyword”的名人名言,换一个试试吧(来自 如来助理)");
				}
			});
		}
    });
}
1;