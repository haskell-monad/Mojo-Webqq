package Mojo::Webqq::Plugin::PushPlug;
use strict;
our $PRIORITY = 98;
use 5.010;
use DateTime::Event::Cron::Quartz;
use Mojo::DOM;
use Encode;
#比较两个日期，如果当前日期大于下一次的日期的话返回1,如果当前日期小于下一次的日期则返回-1
#如果下一次的日期大于当前日期说明执行计划有效，返回两个日期的秒差（多少秒后执行）,否则返回-1(执行计划计划失效)
sub differ{
	my $times = shift;
	my $event = DateTime::Event::Cron::Quartz->new($times);
	my $next_time = $event->get_next_valid_time_after(DateTime->now->set_time_zone("Asia/Shanghai"));
	my $now = DateTime->now()->set_time_zone("Asia/Shanghai");
	if (DateTime->compare($now,$next_time) == -1) {
		return $now->subtract_datetime_absolute($next_time)->seconds;
	}
	return -1;
}
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
my %datas;#保存推送信息
#配置回调
my %callback = (
	weather => \&weather,
	news => \&news,
	soccer => \&soccer,
	score => \&score,
	joke => \&joke,
	riddle => \&riddle,
	qiwen  => \&qiwen,
);
#重新设置某个任务的执行计划
sub init{
	my ($client,$info,$groups,$key) = @_;
	my $array = $datas{$key};
	my $times = @$array[0];
	next unless defined $times;
	my $groups = @$array[1];
	next unless defined $groups;
	my $info = @$array[2];
	my $next_exec_seconds;
	
	do{
		$next_exec_seconds = differ($times);
		$client->debug("($key)----($times)----($next_exec_seconds)");
	} while $next_exec_seconds == 1;

	if ($next_exec_seconds > 1) {
		$client->timer($next_exec_seconds,sub{$callback{$key}($client,$info,$groups,$key)});
		$client->debug("重新设置任务($key)成功, $next_exec_seconds 秒后开始执行($key)任务.");
	}
}
my $god = "文曲星君题戏三界: ";
my $nobody = $god."偌大的三界之中,难道就没有能懂本星君心意之人么.吾独徘徊于天地之间,对酒影成双,知己难求,呜呼哉!";
#文曲星君戏三界
sub riddle{
	my ($client,$info,$groups,$key) = @_;
	my $url = "http://apis.baidu.com/myml/c1c/c1c";

	foreach my $group (@$groups) {
		$client->http_get($url,{json=>1,apikey=>"f23168e0956fe11f6fc44ee61dbfa002"},form=>{id=>-1},sub{
				my $data = shift;
				return unless defined $data;
				my $reply = $god.encode("utf8",$data->{Title});
				my $answer = encode("utf8",$data->{Answer});
				$client->debug($group->{gname}."|题目:$reply|答案:".$answer);
				my $flag = 0;
				my $gid = $group->{gid};
				my $rilldeHandler = sub{
					my($client,$msg) = @_;
					return if $msg->type ne "group_message";
					return if $flag == 1;
					my $content = $msg->content;
					$client->debug("收到回答:".$content);
					if ($content =~ m/$answer/g) {
						$flag = 1;
						my $sender_nick = $msg->sender->displayname;
						$msg->allow_plugin(0);
						#回答正确,游戏结束
						$client->debug($group->{gname}."|群已经结束");
						$client->send_group_message($group,"于千万人之中,文曲星君终于找到了有缘人:\@$sender_nick");
					}
				};
				$client->send_group_message($group,$reply);
				$client->on(receive_message=>$rilldeHandler);
				$client->timer(100,sub{
					if ($flag == 0) {
						$client->send_group_message($group,$nobody."\n答案:($answer)");
					}
					$client->unsubscribe(receive_message=>$rilldeHandler);
				});
		});
	}
	init($client,$info,$groups,$key);
}
#笑话
sub joke{
	my ($client,$info,$groups,$key) = @_;
	my %api = (
		0 => "http://apis.baidu.com/showapi_open_bus/showapi_joke/joke_text",
		1 => "http://apis.baidu.com/showapi_open_bus/showapi_joke/joke_pic",
	);
	my $page = ((int rand 500) + 1);#第几页
	my $which = int rand 20;#第几条，每页最多20条
	my $rand = int rand 2;#文本还是图片
	my $type = $rand==0?"text":"img";
	$client->http_get($api{$rand}."?page=$page",{json=>1,apikey=>"f23168e0956fe11f6fc44ee61dbfa002"},sub{
			my $data = shift;
			unless (defined $data) {
				init($client,$info,$groups,$key);
				return;
			}
			my $reply;
			if ($data->{showapi_res_code} == 0) {
				$reply .= ($data->{showapi_res_body}->{contentlist}->[$which]->{title})."\n".($data->{showapi_res_body}->{contentlist}->[$which]->{$type});
			}
			unless (defined $reply) {
				init($client,$info,$groups,$key);
				return;
			}
			$reply = $info."\n开心一刻: ".encode("utf8",$reply);
			chomp($reply);
			foreach my $group (@$groups) {
				$client->send_group_message($group,$reply);
			}
			init($client,$info,$groups,$key);
	});

}

#周末球赛预告(曼联、阿森纳、切尔西、利物浦、热刺、曼城、皇马、巴萨、马竞、尤文、米兰、国米、拜仁、多特、巴黎)
sub soccer{
	my ($client,$info,$groups,$key) = @_;
	my $nextDay = DateTime->now(time_zone => 'Asia/Shanghai')->add(days => 1)->ymd;
	my $currDay = DateTime->now(time_zone => 'Asia/Shanghai')->ymd;
	$client->http_get("http://www.zhibo8.cc/",{},sub{
			my $data = shift;
			unless (defined $data) {
				init($client,$info,$groups,$key);
				return;
			}
			my $dom = Mojo::DOM->new($data);
			my @box = $dom->find('div.schedule_container > div.box')->each;
			@box = grep(/$currDay|$nextDay/,@box);
			my @msg = ();
			if (scalar(@box) < 3) {
				foreach my $item (@box) {
					$data = Mojo::DOM->new($item);
					my @cbox = $data->find('li')->each;
					@cbox = grep(/曼联|欧洲杯|阿森纳|切尔西|利物浦|热刺|曼彻斯特联|曼彻斯特城|曼城|皇马|巴萨|巴塞罗那|皇家马德里|尤文|米兰|国米|拜仁|拜仁慕尼黑|多特蒙德|多特/,@cbox);
					my $text;
					my $reply;
					my $dataDate;
					foreach my $li (@cbox) {
						$dom = Mojo::DOM->new($li);
						$dom =~ m/data-time=\"([0-9-]+)\s+[0-9:]+\"/g;
						$dataDate = $1;
						$text = $dom->all_text;
						$client->debug("\$text: ".$text);
						next if $text =~ m/(福利|竞猜)+/g;
						$text=~s/^\s+|\s+$//g;
						$text=~s/文字|手机看直播|看美女直播秀|比分|3DNBA游戏|3D中超游戏|欧冠足球新服|足球掌门新服|激战欧冠赛场//g;
						$reply .= $text."\n";
					}
					$client->debug("\$reply: ".$reply);
					push @msg,"$dataDate 重要足球赛事预告\n".$reply;
				}
			}else{
				init($client,$info,$groups,$key);
				return;
			}

			unless (scalar(@msg) > 0) {
				init($client,$info,$groups,$key);
				return;
			}
			#$reply = $info."\n$nextDay 重要足球赛事预告\n".$reply;
			#chomp($reply);
			foreach my $group (@$groups) {
				$client->send_group_message($group,$info);
				foreach my $mes (@msg) {
					chomp($mes);
					$client->send_group_message($group,$mes);
				}
			}
			init($client,$info,$groups,$key);
	});
}
#实时新闻
sub news{
	my ($client,$info,$groups,$key) = @_;
	$client->http_get("http://apis.baidu.com/songshuxiansheng/news/news",{apikey=>"f23168e0956fe11f6fc44ee61dbfa002",json=>1},sub{
			my $data = shift;
			unless (defined $data) {
				init($client,$info,$groups,$key);
				return;
			}
			my $reply;
			if ($data->{errMsg} eq 'success') {
				$reply .= encode("utf8",$data->{retData}->[0]->{title})."\n".($data->{retData}->[0]->{url});
			}
			unless (defined $reply) {
				init($client,$info,$groups,$key);
				return;
			}
			$reply = $info."\n".$reply;
			chomp($reply);
			foreach my $group (@$groups) {
				$client->send_group_message($group,$reply);
			}
			init($client,$info,$groups,$key);
	});
}
#奇闻异事
sub qiwen{
	my ($client,$info,$groups,$key) = @_;
	$client->http_get("http://apis.baidu.com/txapi/qiwen/qiwen?num=10",{apikey=>"f23168e0956fe11f6fc44ee61dbfa002",json=>1},sub{
			my $data = shift;
			unless (defined $data) {
				init($client,$info,$groups,$key);
				return;
			}
			my $reply;
			if ($data->{msg} eq 'ok') {shortUrl
				$reply .= "标题: ".encode("utf8",$data->{0}->{title});
				$reply .=  "\n图片地址: ".shortUrl($data->{0}->{picUrl});
				$reply .=  "\n奇闻地址: ".shortUrl($data->{0}->{url});
			}
			unless (defined $reply) {
				init($client,$info,$groups,$key);
				return;
			}
			$reply = $info."\n".$reply;
			chomp($reply);
			foreach my $group (@$groups) {
				$client->send_group_message($group,$reply);
			}
			init($client,$info,$groups,$key);
	});
}
#NBA比分
sub score{
	my ($client,$info,$groups,$key) = @_;
	my $date = DateTime->now->set_time_zone("Asia/Shanghai")->ymd;
	$client->http_get("http://match.sports.sina.com.cn/livecast/show_date.php?date=$date",{},sub{
			my $data = shift;
			unless (defined $data) {
				init($client,$info,$groups,$key);
				return;
			}
			$data = decode('gb2312',$data);
			my $dom = Mojo::DOM->new($data);
			my @box = $dom->find('table.tab_01 > tr')->each;
			@box = grep(/NBA/,@box);
			my $reply;
			foreach my $item (@box) {
				$dom = Mojo::DOM->new($item);
				$reply .= ($dom->find("span.dc1 > a")->[0]->text)."(".$dom->find("span.red20 > a")->[0]->text.")".$dom->find("span.dc4 > a")->[0]->text."(".$dom->find("td.e")->[0]->text.")"."\n";
			}
			unless (defined $reply) {
				init($client,$info,$groups,$key);
				return;
			}
			$reply = "NBA今日战况\n".encode("utf8",$reply);
			$reply = $info."\n".$reply;
			chomp($reply);
			foreach my $group (@$groups) {
				$client->send_group_message($group,$reply);
			}
			init($client,$info,$groups,$key);
	});
}
#天气
sub weather{
	my ($client,$info,$groups,$key) = @_;
	$client->http_get("http://www.tianqihoubao.com/yubao/beijing.html",{},sub{
			my $html = shift;
			unless (defined $html) {
				init($client,$info,$groups,$key);
				return;
			}
			$html = decode('gbk',$html);
			my $dom = Mojo::DOM->new($html);
			my $tr = $dom->find('div.wdetail')->[0];
			$dom = Mojo::DOM->new($tr);
			my $title = $dom->at('h1')->text;
			my @trs = $dom->find("tr")->each;
			shift @trs;
			my $node;
			my $last;
			my @reply=();
			foreach my $item (@trs) {
				$dom = Mojo::DOM->new($item);
				my $first = $dom->find("td,b")->[0]->text;
				if ($first =~ /\d{4}-\d{2}-\d{2}/g) {
					$last = $first;
					$node = $dom->find("td,b")->map("text")->join(",");
					$node =~ s/,,/,/g;
				}else{
					$node = $dom->find("td,b")->map("text")->join(",");
					$node =~ s/,,/,/g;
					$node = $last.",".$node;
				}
				$node =~ s/(\r|\n|\s)//g;
				push(@reply,$node);
			}
			unless (scalar(@reply) > 0) {
				init($client,$info,$groups,$key);
				return;
			}
			my $reply = "$title\n".join("\n",@reply);
			$reply = $info."\n".encode("utf8",$reply);
			chomp($reply);
			foreach my $group (@$groups) {
				$client->send_group_message($group,$reply);
			}
			init($client,$info,$groups,$key);
	});
};

sub call {
    my $client = shift;
    my $data  = shift;
	my $event;
	my $nextTime;
	if (ref($data) eq "HASH") {
		while(my($key,$hash) = each(%$data)) {
			if (ref($hash) eq "HASH") {
				my $times = $hash->{times};
				next unless defined $times;
				my $groups = $hash->{groups};
				next unless defined $groups;
				my $info = $hash->{info};
				$client->debug("key: $key,times: $times, groups: $groups, message: $info\n");
				$datas{$key} = [$times,$groups,$info];
				my $next_exec_seconds = differ($times);
				if ($next_exec_seconds > 0) {
					$client->timer($next_exec_seconds,sub{$callback{$key}($client,$info,$groups,$key)});
					$client->debug("初始化任务($key)成功, $next_exec_seconds 秒后开始执行($key)任务.");
				}
			}
		}
	}
}
1;