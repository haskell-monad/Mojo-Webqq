package Mojo::Webqq::Plugin::Cartoon;
$Mojo::Webqq::Plugin::Cartoon::PRIORITY = 98;
use Encode;
=cut
	usage:
		二次元
		动画
		漫画
		动画片
=cut
my $api = "http://apis.baidu.com/acman/zhaiyanapi/tcrand?fangfa=json";
sub call{
    my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		my $reply;
		if ($msg->content =~ m/二次元|动画|漫画|动画片/) {
			$msg->allow_plugin(0);
			$client->http_get($api,{json=>1,apikey=>"f23168e0956fe11f6fc44ee61dbfa002"},sub{
				my $data = shift;
				return unless defined $data;
				my $reply;
				$reply .= encode("utf8",$data->{catcn})."|".encode("utf8",$data->{source});
				if (encode("utf8",$data->{show})) {
					$reply .= encode("utf8",$data->{show}).":";
				}else{
					$reply .= ":";
				}
				$reply .=encode("utf8",$data->{taici});
				$client->reply_message($msg,$reply);
			});
		}else{
			return;
		}
	});
}
1;