package Mojo::Webqq::Plugin::Poetry;
$Mojo::Webqq::Plugin::Poetry::PRIORITY = 99;
use POSIX qw(strftime);
use Encode;
=cut
	数据接口来自急速数据。
	usage:
		只支持逗号、空格分割。
		唐诗 白日
		宋词 扬州慢
		绕口令 白菜
		生孩 24,12
		BMI male|female 172 60
		历史上的今天 12 29
=cut

my $appkey = "d9a3a94f5b3769f6";
my %hash = (
	tangshi			=>  "http://api.jisuapi.com/tangshi/search",
	songci			=>  "http://api.jisuapi.com/songci/search",
	raokouling		=>  "http://api.jisuapi.com/rkl/search",
	snsn			=>	"http://api.jisuapi.com/snsn/sex",
	weight			=>	"http://api.jisuapi.com/weight/bmi",
	history			=>	"http://api.jisuapi.com/todayhistory/query",
);

#唐诗宋词
sub tangshiAndSongci{
	my $data = shift;
	return unless defined $data;
	my $reply;
	my $titles = encode("utf8",$data->{result}->{list}->[0]->{title});
	return unless defined $titles;
	$reply .= "标题: ".$titles;
	$reply .= "\n作者: ".encode("utf8",$data->{result}->{list}->[0]->{author});
	$reply .= "\n分类: ".encode("utf8",$data->{result}->{list}->[0]->{type});
	my $con;
	if (length($data->{result}->{list}->[0]->{content}) > 45) {
		$con = substr($data->{result}->{list}->[0]->{content},0,45).decode("utf8","(已截断)");
		$con = encode("utf8",$con);
	}else{
		$con = encode("utf8",$data->{result}->{list}->[0]->{content});
	}
	$reply .= "\n内容: ".$con;
	return $reply;
}

#绕口令
sub raokouling{
	my $data = shift;
	return unless defined $data;
	my $reply;
	my $titles = encode("utf8",$data->{result}->{list}->[0]->{title});
	return unless defined $titles;
	$reply .= "标题: ".$titles;
	my $con;
	if (length($data->{result}->{list}->[0]->{content}) > 45) {
		$con = substr($data->{result}->{list}->[0]->{content},0,45).decode("utf8","(已截断)");
		$con = encode("utf8",$con);
	}else{
		$con = encode("utf8",$data->{result}->{list}->[0]->{content});
	}
	$reply .= "\n内容: ".$con;
	return $reply;
}

#生男生女
sub snsn{
	my $data = shift;
	return unless defined $data;
	my $reply = "我相信你们一定可以生个".encode("utf8",$data->{result}->{sex})."孩儿.";
	return $reply;
}

#标准体重计算器
sub weight{
	my $data = shift;
	return unless defined $data;
	my $reply;
	my $bmi = $data->{result}->{bmi};
	return unless defined $bmi;
	$reply .= "BMI指数: ".$bmi;
	$reply .= "\n正常BMI指数: ".encode("utf8",$data->{result}->{normbmi});
	$reply .= "\n理想体重: ".($data->{result}->{idealweight});
	$reply .= "\n水平: ".encode("utf8",$data->{result}->{level});
	$reply .= "\n相关疾病发病的危险: ".encode("utf8",$data->{result}->{danger});
	$reply .= "\n是否正常: ".($data->{result}->{status});
	return $reply;
}

#历史上的今天
sub history{
	my $data = shift;
	return unless defined $data;
	my $reply;
	my $array = $data->{result};
	return unless defined $array;
	my $count = scalar(@$array);
	if ($count <= 10) {
		for (0..$count-1) {
			$reply .= $data->{result}->[$_]->{year}."年".$data->{result}->[$_]->{month}."月".$data->{result}->[$_]->{day}."日,".encode("utf8",$data->{result}->[$_]->{title})."\n";
		}
	}else{
		for (0..10) {
			$reply .= $data->{result}->[$_]->{year}."年".$data->{result}->[$_]->{month}."月".$data->{result}->[$_]->{day}."日,".encode("utf8",$data->{result}->[$_]->{title})."\n";
		}
		$reply .= "(已截断)";
	}
	chomp($reply);
	return $reply;
}

sub call{
	my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		my $content = $msg->content;
		if ($content =~ m#^(唐诗|宋词|绕口令|生孩|生娃|bmi|BMI|历史上的今天)\s+#) {
			$msg->allow_plugin(0);
			my $sender_nick = $msg->sender->displayname;
			my $type = $1;

			my %forms = (
				appkey=>$appkey,
			);
			$content=~s/唐诗|宋词|绕口令//g;
			
			my $url;
			if ($type =~ m/唐诗/) {
				$url = $hash{tangshi};
				$forms{keyword}=decode("utf8",$content);
			}elsif ($type =~ m/宋词/) {
				$url = $hash{songci};
				$forms{keyword}=decode("utf8",$content);
			}elsif ($type =~ m/绕口令/) {
				$url = $hash{raokouling};
				$forms{keyword}=decode("utf8",$content);	
			}elsif ($type =~ m/历史上的今天/) {
				$url = $hash{history};
				$content=~s/历史上的今天//g;
				$content=~s/^\s+|\s+$//g;
				my @params = split(/,|\s/,$content);
				$client->debug("历史上的今天参数: ".scalar(@params));
				return unless scalar(@params) == 2;
				my $month = $params[0];
				my $day = $params[1];
				if ($month < 1 || $month > 12 || $day < 1 || $day > 31) {
					$client->reply_message($msg,"\@$sender_nick 亲,获取($type)数据失败:请确认月份范围1-12,日期范围1-31.(来自 如来助理)");
					return;
				}
				$forms{month}=$month;	
				$forms{day}=$day;
			}elsif ($type =~ m/BMI|bmi/) {
				$url = $hash{weight};
				$content=~s/BMI|bmi//g;
				$content=~s/^\s+|\s+$//g;
				my @params = split(/,|\s/,$content);
				$client->debug("标准体重参数: ".scalar(@params));
				return unless scalar(@params) == 3;
				my $sex = $params[0];
				if ($sex ne "male" && $sex ne "female") {
					$client->reply_message($msg,"\@$sender_nick 亲,获取($type)数据失败:请使用:BMI (male|female) height weight格式来查询(来自 如来助理)");
					return;
				}
				my $height = $params[1];
				my $weight = $params[2];
				$forms{sex}=$sex;
				$forms{height}=$height;
				$forms{weight}=$weight;
			}elsif ($type =~ m/生孩|生娃/) {
				$url = $hash{snsn};
				$content=~s/生孩|生娃//g;
				$content=~s/^\s+|\s+$//g;
				my @params = split(/,|\s/,$content);
				$client->debug("生孩参数: ".scalar(@params));
				return unless scalar(@params) == 2;
				my $age = $params[0];
				my $month = $params[1];
				$age=~s/^\s+|\s+$//g;
				$month=~s/^\s+|\s+$//g;
				if ($age < 18 || $age > 45 || $month < 1 || $month > 12) {
					$client->reply_message($msg,"\@$sender_nick 亲,获取($type)数据失败:请确认年龄范围18-45,月份范围1-12.(来自 如来助理)");
					return;
				}
				$forms{age}=$age;
				$forms{month}=$month;
			}else{
				return;
			}
			$content=~s/^\s+|\s+$//g;
			my $reply;
			$client->debug("类型:($type)".$url);
			$client->http_get($url,{json=>1},form=>\%forms,sub{
				my $data = shift;
				return unless defined $data;
				if ($data->{msg} eq 'ok') {
					if ($type =~ m/唐诗|宋词/) {
						$reply = tangshiAndSongci($data);
					}elsif ($type =~ m/绕口令/) {
						$reply = raokouling($data);
					}elsif ($type =~ m/生孩|生娃/) {
						$reply = snsn($data);
					}elsif ($type =~ m/BMI|bmi/) {
						$reply = weight($data);
					}elsif ($type =~ m/历史上的今天/) {
						$reply = history($data);
					}else{
						return;
					}
					return unless defined $reply;
					$client->reply_message($msg,"\@$sender_nick 亲,已为您找到($type)“$content”(来自 如来助理)\n".$reply);
				}else{
					$client->debug("获取($type)失败: ".encode("utf8",$data->{msg}));
					$client->reply_message($msg,"\@$sender_nick 亲,获取($type)数据失败: ".encode("utf8",$data->{msg}).".(来自 如来助理)");
				}
			});
		}
    });
}
1;
