package Mojo::Webqq::Plugin::Wooyun;
$Mojo::Webqq::Plugin::Wooyun::PRIORITY = 99;
use POSIX qw(strftime);
use Encode;
=cut
	usage:
		乌云 -h
		wooyun -h
		乌云 等待认领
		乌云 最新公开
		乌云 最新确认
		乌云 最新提交
=cut
my %helps = (
		"等待认领" => "1",
		"最新公开" => "2",
		"最新确认" => "3",
		"最新提交" => "4",
);
my %hash = (
		"等待认领" => "http://apis.baidu.com/apistore/wooyun/unclaim",
		"最新公开" => "http://apis.baidu.com/apistore/wooyun/public",
		"最新确认" => "http://apis.baidu.com/apistore/wooyun/confirm",
		"最新提交" => "http://apis.baidu.com/apistore/wooyun/submit",
		"1" => "http://apis.baidu.com/apistore/wooyun/unclaim",
		"2" => "http://apis.baidu.com/apistore/wooyun/public",
		"3" => "http://apis.baidu.com/apistore/wooyun/confirm",
		"4" => "http://apis.baidu.com/apistore/wooyun/submit",
);
my %status = (
		0=>"待厂商确认处理",
		1=>"厂商已经确认",
		2=>"漏洞通知厂商但厂商忽略",
		3=>"未联系到厂商或厂商忽略",
		4=>"正在联系厂商并等待认领"
);
sub call{
	my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		my $content = $msg->content;
		if ($content =~ m#^(乌云|wooyun)\s+#) {
			$msg->allow_plugin(0);
			my $sender_nick = $msg->sender->displayname;
			$content=~s/乌云|wooyun//g;
			$content=~s/^\s+|\s+$//g;
			return unless defined $content;
			my $reply;
			if ($content eq '-l' || $content eq '-h') {
				while (my($k,$v)=each %helps) {
					$reply .= $k."(".$v.") ";
				}
				$client->reply_message($msg,"\@$sender_nick 亲, 目前支持四种状态的查询(来自 如来助理):\n$reply\n您可以使用:“乌云 XX”来查询，如查询“等待认领”可以使用以下命令:\n乌云 等待认领\n乌云 1\nwooyun 1");	
				return;
			}
			my $url = $hash{$content};
			return unless defined $url;
			$client->http_get($url,{json=>1,apikey=>"f23168e0956fe11f6fc44ee61dbfa002"},form=>{limit=>10},sub{
				my $data = shift;
				return unless defined $data;
				my $length = scalar(@$data);
				$client->debug("获取到乌云相关信息 $length 条.");
				if ($length > 0) {
					#序号、标题(发布日期,状态,作者)
					#1、利用搜狐邮箱XSS劫持用户邮件(2016-01-04,q601333824,漏洞通知厂商但厂商忽略)
					my $index;
					for (0..$length-1) {
						$index = $_ + 1;
						$reply .= $index."、".encode("utf8",$data->[$_]->{title})."(".encode("utf8",$data->[$_]->{author}).",".$data->[$_]->{date}.",".$status{$data->[$_]->{status}}.")\n";
						if ($index % 2 == 0) {
							chomp($reply);
							return unless defined $reply;
							if ($_ == 2) {
								$client->reply_message($msg,"\@$sender_nick 亲,已为您找到相关信息(来自 如来助理)\n$reply");
							}else{
								$client->reply_message($msg,$reply);
							}
							$reply=undef;
						}
					}
				}
			});
		}
    });
}
1;
