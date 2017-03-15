package Mojo::Webqq::Plugin::Monitor;
$Mojo::Webqq::Plugin::Monitor::PRIORITY = 99;
use Encode;
=cut
	监控群信息内容
	usage:
		如来 启动监控
		sudo 如来 停止监控
=cut
my $url = "http://apis.baidu.com/tutusoft/shajj/shajj";
my %group_hash = ();
sub call{
	my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		my $group_id = $msg->group_id;
		my $content = $msg->content;
		my $sender_nick = $msg->sender->displayname;
		if ($content =~ m#^(sudo\s*)?如来\s+(启动|停止)监控$#g) {
			$msg->allow_plugin(0);
			my $auth = $1;#sudo
			my $type = $2;#类型
			$auth=~s/^\s+|\s+$//g;
			$type=~s/^\s+|\s+$//g;
			return unless defined $type;
			if ($type eq "启动") {
				if (exists $group_hash{$group_id}) {
					#已经启动了...
					$client->reply_message($msg,"\@$sender_nick 如来助理已经在监控本群信息了(来自 如来助理).");
				}else{
					$group_hash{$group_id} = "1";
					$client->reply_message($msg,"\@$sender_nick 启动监控成功,如来助理开始监控本群信息(来自 如来助理).");
				}
			}elsif ($type eq "停止") {
				if ($auth eq 'sudo') {
					delete $group_hash{$group_id};
					$client->reply_message($msg,"\@$sender_nick 如来助理已成功停止监控本群信息(来自 如来助理).");
				}else{
					$client->reply_message($msg,"\@$sender_nick 小伙儿,你没有权限停止监控,请联系如来大神.(来自 如来助理).");
				}
			}else{
				return;
			}
		}else{
			if (exists $group_hash{$group_id}) {
				#说明该群正在被监控
				return if $msg->type ne "group_message";
				$client->debug("收到受监控信息($group_id):".$content);
				$client->http_post($url,{json=>1,apikey=>"f23168e0956fe11f6fc44ee61dbfa002"},form=>{content=>decode("utf8",$content)},sub{
					my $data = shift;
					return unless defined $data;
					my $reply;
					if ($data->{result} eq "1") {
						my $nature;
						if ($data->{nature} eq "1") {
							$nature="黑名单";
						}elsif ($data->{nature} eq "2") {
							$nature="灰名单";
						}
						$reply = "\@$sender_nick 您发送的信息中“".encode("utf8",$data->{words})."”属于“".encode("utf8",$data->{categoryName})."”,已经被列入到".$nature."中(来自 如来助理)."
					}elsif ($data->{result} eq "2") {
						
					}
					return unless defined $reply;
					$client->reply_message($msg,$reply);
				});
			}
		}
    });
}
1;
