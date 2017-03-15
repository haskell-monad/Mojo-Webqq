package Mojo::Webqq::Plugin::SongKTV;
$Mojo::Webqq::Plugin::SongKTV::PRIORITY = 99;
use POSIX qw(strftime);
use Encode;
=cut
	usage:
		ktv 情网
		KTV 那一夜
		KTV 情网 张学友
=cut

sub shortUrl{
	my ($client,$url) = @_;
	my $data = $client->http_post("http://dwz.cn/create.php",{json=>1,retry_times=>2},form=>{url=>$url,alias=>undef,access_type=>"web"});
	my $tinyurl;
	if ($data->{status} != 0) {
		$tinyurl = $url;
	}else{
		$tinyurl = $data->{tinyurl};
	}
	$client->debug("长地址: $url");
	$client->debug("短地址生成: $tinyurl");
	return $tinyurl;
}

sub call{
	my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		my $content = $msg->content;
		if ($content =~ m#^(ktv|KTV)\s+#) {
			$msg->allow_plugin(0);
			my $sender_nick = $msg->sender->displayname;
			$content=~s/ktv|KTV//g;
			$content=~s/^\s+|\s+$//g;
			my $reply;
			my $url = "http://apis.baidu.com/geekery/music/query";
			$client->http_get($url,{json=>1,apikey=>"f23168e0956fe11f6fc44ee61dbfa002"},form=>{limit=>1,p=>1,s=>decode("utf8",$content)},sub{
				my $data = shift;
				return unless defined $data;
				if ($data->{status} eq 'success') {
					my $songName = encode("utf8",$data->{data}->{data}->{list}->[0]->{songName});
					my $url = shortUrl($client,$data->{data}->{data}->{list}->[0]->{songUrl});
					return unless defined $songName;
					return unless defined $url;
					$reply .= "歌曲名称: ".$songName;
					$reply .= "\n歌手名称: ".encode("utf8",$data->{data}->{data}->{list}->[0]->{userName});
					$reply .= "\n专辑名称: ".encode("utf8",$data->{data}->{data}->{list}->[0]->{albumName});
					#$reply .= "\n图片地址: ".$data->{data}->{data}->{list}->[0]->{albumPic};
					#$reply .= "\n歌曲地址: ".$data->{data}->{data}->{list}->[0]->{songUrl};
					$reply .= "\n图片地址: ".shortUrl($client,$data->{data}->{data}->{list}->[0]->{albumPic});
					$reply .= "\n歌曲地址: ".$url;
					return unless defined $reply;
					$client->reply_message($msg,"\@$sender_nick 亲,已为您找到歌曲“$content”(来自 如来助理)\n$reply");
				}elsif ($data->{status} eq 'failed') {
					$client->debug("KTV fail: ".$data->{msg});
					$client->reply_message($msg,"\@$sender_nick 亲,没有找到“$content”,换一首试试吧(来自 如来助理)");
				}
			});
		}
    });
}
1;