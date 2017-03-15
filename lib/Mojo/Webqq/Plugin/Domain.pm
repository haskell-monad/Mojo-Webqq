package Mojo::Webqq::Plugin::Domain;
$Mojo::Webqq::Plugin::Domain::PRIORITY = 98;
use Mojo::DOM;
use Encode;
=cut
	域名信息查询
	usage:
		domain ikang.com
@XXX
域名:ikang.com
标题:爱康网:体检_就医安排_私人医生 - 爱康国宾
关键词:体检,健康体检,体检中心,体检机构,健康管理,网上挂号
简介:爱康国宾是一家拥有8年体检经验健康管理机构(已截断)
Alexa Rank:104,074,谷歌PR:PageRank7
谷歌收录:12,100,百度收录:40,900,反链:249
Server:Apache/2.2.10 (Unix) PHP/4.4.9
IP地址:59.151.27.136
纬度:39.9289,经度:116.3883,定位:China
注册商:PAYCENTER.COM.CN,注册日期:2004-01-02,到期日期:2022-01-02
Whois Server:whois.paycenter.com.cn
Email:lee.zhankang.com
域名状态:ok,更新日期:8 month Ago
=cut
use 5.010;
sub extract{
	my $site = shift;
	my $dom = Mojo::DOM->new($site);
	my @trs = $dom->find("tr")->each;
	my $rs;
	foreach my $item (@trs) {
		$dom = Mojo::DOM->new($item);
		next unless scalar($dom->find("td")->each) == 2;
		my $v = $dom->all_text(0);
		next unless $v !~ m/域名|简介|关键词/;
		$v=~s/^\s+|\s+$//g;
		$v=~s/\s+//g;
		next unless $v !~ m/:$/;
		if($v =~ m/谷歌|谷歌PR/){
			$v .= $dom->find("img")->map(attr => 'alt')->[0];
		}
		if ($v =~ m/收录|纬度|经度|到期日期|定位|谷歌PR/) {
			$rs .= "  ".$v;
		}else{
			$rs .= "\n".$v;
		}
	}
	return $rs;
}
sub parse{
	my $data = shift;
	my $dom = Mojo::DOM->new($data);
	my $reply;
	my @types = qw(#site #server #whois);
	foreach my $type (@types) {
		$reply .= extract($dom->at($type));
	}
	return $reply;
}

sub call{
    my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		my $sender_nick = $msg->sender->displayname;
		my $content = $msg->content;
		if ($content =~ m/^domain\s+(.*)/g) {
			$msg->allow_plugin(0);
			my $domain = $1;
			$domain=~s/^\s+|\s+$//g;
			my $reply;
			$client->http_get("http://www.eachinfo.com/$domain",{},sub{
				my $data = shift;
				return unless defined $data;
				$reply = parse($data);
				return unless defined $reply;
				$client->reply_message($msg,"\@$sender_nick \n域名:$domain".$reply);
			});
		}
	});
}
1;
