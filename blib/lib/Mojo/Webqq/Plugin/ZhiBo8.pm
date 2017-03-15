package Mojo::Webqq::Plugin::ZhiBo8;
$Mojo::Webqq::Plugin::ZhiBo8::PRIORITY = 98;
use Mojo::DOM;
use Encode;
=cut
	ZhiBo8 直播吧
	usage:
		直播吧 -h
		直播吧>>>(足球|篮球|其他|英超)
		直播吧2>>>曼联
		直播吧3>>>达拉斯小牛
		直播吧4>>>广东
		
		@XXX
		12月04日 星期五
			11:35 NBA常规赛 爵士 vs 魔术 QQ直播
			11:35 欧巡赛-澳大利亚PGA锦标赛第二轮
			10:30 欧巡赛-澳大利亚PGA锦标赛第二轮 
		12月06日 星期一
			11:35 NBA常规赛 爵士 vs 魔术 QQ直播
			11:35 欧巡赛-澳大利亚PGA锦标赛第二轮
			11:35 澳超 悉尼FC vs 纽卡斯尔喷射机 乐视直播
		12月06日 星期一
			11:35 NBA常规赛 爵士 vs 魔术 QQ直播
			11:35 欧巡赛-澳大利亚PGA锦标赛第二轮
			11:35 澳超 悉尼FC vs 纽卡斯尔喷射机 乐视直播
=cut
my $api = "http://www.zhibo8.cc/";
sub call{
    my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		my $sender_nick = $msg->sender->displayname;
		my $reply;
		my $content = $msg->content;
		if ($content =~ m/^直播吧\s+-h/g) {
			$reply = "\@$sender_nick 您可以使用以下标签查询相关赛事 (来自 如来助理)\n如输入: 直播吧>>>曼联\n";
			my $tags = "足球 中超 英超 西甲 德甲 意甲 法甲 俄超 欧冠 欧洲冠军 欧联杯 欧罗巴\n曼联 曼彻斯特联 曼城 曼彻斯特城 切尔西 利物浦 阿森纳 足总杯 联赛杯\n社区盾 皇马 皇家马德里 巴萨 巴塞罗那 AC米兰 国际米兰 国米 尤文图斯 尤文\n拜仁 德国杯 德国超级杯 法国杯 国王杯 西班牙超级杯 意大利杯 意大利超级杯\n亚洲杯 足协 恒大 中国男足 国足 亚洲冠军 亚冠 篮球 NBA CBA 篮 ncaa sbl\n骑士 湖人 热火 火箭 雷霆 公牛 凯尔特人 尼克斯 快船 小牛 马刺 篮网 网队\n森林狼 灰熊 掘金 勇士 爵士 开拓者 步行者 老鹰 雄鹿 美国男篮 中国男篮 广东\n其他 F1 网球 澳网 温网 法网 美网 ATP WTA 斯诺克 台球 桌球 NFL MLB NHL UFC\n拳 拳击 高尔夫 田径 田联 排球 男排 女排 羽毛球 羽 苏迪曼杯 尤伯杯 乒 乒乓球";
			$reply .= $tags;
			$client->reply_message($msg,$reply);		
		}elsif($content =~ m/^直播吧(\d+)?>>>/g) {
			$msg->allow_plugin(0);
			my $limit = $1;
			$limit=~s/^\s+|\s+$//g;
			if (!$limit) {
				$content=~s/直播吧>>>//g;
				$limit  = 10;
			}else{
				$content=~s/直播吧$limit>>>//g;
				if ($limit < 2) {
					$limit  = 5;
				}
			}
			$content=~s/^\s+|\s+$//g;
			return unless $content;
			$client->http_get($api,{},sub{
				my $data = shift;
				return unless defined $data;
				#$data = decode("utf8",$data);
				my $dom = Mojo::DOM->new($data);
				my @box = $dom->find('div.schedule_container > div.box')->each;
				my @retval = splice (@box,-(scalar(@box) - 3));
				my @lis;
				$reply = "\@$sender_nick 近期 “ $content ” 赛事如下:\n-------------------------------------\n";
				$client->debug("\$reply: $reply\n");
				my $time;
				my $text;
				foreach my $item (@box) {
					$dom = Mojo::DOM->new($item);
					$time = $dom->find("div.titlebar > h2")->[0]->text;#日期
					$reply .= $time."\n";
					#获取赛事信息
					@lis = $dom->find("div.content > ul > li")->grep(sub{$_->attr("label") =~ m/$content/g})->each;
					my $line;
					foreach my $li (@lis) {
						$dom = Mojo::DOM->new($li);
						$text = $dom->all_text;
						$client->debug("\$text: ".$text);
						next if $text =~ m/(福利|竞猜)+/g;
						$text=~s/^\s+|\s+$//g;
						$text=~s/文字|手机看直播|看美女直播秀|比分|3DNBA游戏|3D中超游戏|欧冠足球新服|足球掌门新服//g;
						$line .= "\t".$text."\n";
						#$reply .= "\t".$text."\n";
					}
					if(count_lines($line) > $limit){
						$client->debug("记录太长,当前记录有".count_lines($line)."行,只需要保留 $limit 行.开始截取.");
						$line  = join "\n",(split /\r?\n/,$line,$limit+1)[0..$limit-1];
						$line .= "\n\t------------------------------------------------(已截断)\n";
					}
					$reply .= $line;
				}
				chomp($reply);
				#if(count_lines($reply) > 25){
					#$client->debug("count_line: ".count_lines($reply));
					#$reply  = join "\n",(split /\r?\n/,$reply,26)[0..24];
					#$reply .= "\n\t------------------------------------------------(已截断)";
				#}
				$client->reply_message($msg,$reply);
			});
		}
	});
}
1;
sub count_lines{
    my $data = shift;
    my $count =()=$data=~/\r?\n/g;
    return $count++;
}