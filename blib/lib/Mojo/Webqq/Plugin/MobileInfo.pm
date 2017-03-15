package Mojo::Webqq::Plugin::MobileInfo;
$Mojo::Webqq::Plugin::MobileInfo::PRIORITY = 98;
use Mojo::DOM;
use Encode;
=cut
	usage:
		手机 18201127710
=cut
my $api = "http://www.ip138.com:8080/search.asp";
sub call{
    my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		my $sender_nick = $msg->sender->displayname;
		if ($msg->content =~ m/^手机\s+([0-9]+)\s*$/g) {
			$msg->allow_plugin(0);
			my $phone = $1;
			$phone=~s/^\s+|\s+$//g;
			return unless $phone;
			my $reply;
			$client->http_get("$api?mobile=$phone&action=mobile",{},sub{
				my $data = shift;
				return unless defined $data;
				$data =~ s/&nbsp;//g;
				my $dom = Mojo::DOM->new($data);
				my @commands = $dom->find('td.tdc2')->each;
				#$client->debug(join("  ",@commands));
				if (scalar(@commands) == 5) {
					$reply .= "\@$sender_nick 您查询的手机号码信息如下:\n";
					$reply .= "手机号: ".(shift @commands)->text."\n";
					$reply .= "归属地: ".encode("utf-8",decode("gbk",(shift @commands)->text))."\n";
					$reply .= "卡类型: ".encode("utf-8",decode("gbk",(shift @commands)->text))."\n";
					$reply .= "区  号: ".(shift @commands)->text."\n";
					$reply .= "邮  编: ".(shift @commands)->text;
				}
				unless ($reply) {
					return;
				}
				$client->reply_message($msg,$reply);
			});
		}
	});
}
1;