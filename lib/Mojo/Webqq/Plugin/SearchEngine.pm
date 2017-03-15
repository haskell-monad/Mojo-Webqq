package Mojo::Webqq::Plugin::SearchEngine;
$Mojo::Webqq::Plugin::SearchEngine::PRIORITY = 99;
use POSIX qw(strftime);
use Encode;
use Mojo::DOM;
use strict;
=cut
	usage:
		网盘 spring
		磁力搜 老炮儿
=cut

sub shortUrl{
	my ($client,$url) = @_;
	$url = "http://www.cilisou.cn$url";
	my $data = $client->http_post("http://dwz.cn/create.php",{json=>1,retry_times=>2},form=>{url=>$url,alias=>undef,access_type=>"web"});
	my $tinyurl;
	if ($data->{status} != 0) {
		$tinyurl = $url;
	}else{
		$tinyurl = $data->{tinyurl};
	}
	$client->debug("长地址: $url");
	$client->debug("短地址生成: $tinyurl");
	$tinyurl =~ s/http:/qq:/;
	return $tinyurl;
}

my %hash = (
	1 => "http://www.wangpansou.cn/s.php",
	2 => "http://www.cilisou.cn/s.php",
);

sub call{
	my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		my $content = $msg->content;
		if ($content =~ m#^(网盘|磁力搜)\s+#) {
			$msg->allow_plugin(0);
			my $sender_nick = $msg->sender->displayname;
			my $type = $1;
			$content=~s/网盘|磁力搜//g;
			$content=~s/^\s+|\s+$//g;
			my %params = ();
			$type=~s/^\s+|\s+$//g;
			my $url;
			if ($type eq "网盘") {
				$url = $hash{1};
				$params{wp}=0;
				$params{ty}="gn";
				$params{op}="gn";
				$params{q}=decode("utf8",$content);
			}elsif ($type eq "磁力搜") {
				$url = $hash{2};
				$params{q}=decode("utf8",$content);
			}
			$client->debug("\$type:$type,\$url:$url");
			$client->http_get($url,{},form=>\%params,sub{
				my $data = shift;
				return unless defined $data;
				my $dom = Mojo::DOM->new($data);
				my @trs = $dom->find("#search_res > table")->[0]->children("tr")->each;
				my $title;
				my $str;
				my $reply;
				my $size;
				foreach my $tr (@trs) {
					$dom = Mojo::DOM->new($tr);
					$str = $dom->all_text;
					$str=~s/^\s+|\s+$//g;
					next if $str eq "";
					next if $str =~ m/一页/;
					$size = encode("utf8",$dom->find("td span")->[1]->text);
					$size =~ s/&nbsp;|\s//g;
					$str = shortUrl($client,$dom->find("a")->map(attr => 'href')->[0])." ( 大小: ".$size.", 下载: ".$dom->find("td span")->[5]->text." )";
					$reply .= $dom->find("td")->[0]->text."、".$str."\n";
				}
				if (defined $reply) {
					chomp($reply);
					$client->reply_message($msg,"\@$sender_nick 亲,已为您找到“$content”,请将qq:替换成http:(来自 如来助理)\n$reply");
				}
			});
		}
    });
}
1;