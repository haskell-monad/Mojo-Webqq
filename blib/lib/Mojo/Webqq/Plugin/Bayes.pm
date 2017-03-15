package Mojo::Webqq::Plugin::Bayes;
$Mojo::Webqq::Plugin::Bayes::PRIORITY = 110;
use Mojo::DOM;
use Lingua::Han::PinYin;
use Encode;
use Storable qw(retrieve nstore);
=start
	usage:
		1表示是(迟到),0表示否(未迟到)
			  "943406539,$outlook,$degree,$windy,$flag;
		记录>>>qq号码,前景,温度,风,1|0
	如：记录>>>943406539,日期?,河南,1
	
	ok如：记录>>>943406539,小到中雨,25℃,北风3-4级,0

		预测>>>qq号码,3
	ok如：预测>>>943406539|小到中雨,25℃,北风3-4级		预测用户943406539，小到中雨,25℃,北风3-4级 时是否会迟到
	
	如：预测>>>943406539|新乡|3							预测新乡的用户943406539 未来3天是否会迟到
	如：预测>>>943406539|新乡							预测新乡的用户943406539 明天是否会迟到
	如：预测>>>943406539								预测用户943406539 明天是否会迟到（根据qq获取所在城市）

	天气>>>房山
	天气>>>fangshan
=cut

sub call{
    my $client = shift;
    my $data = shift;
	my $file = $data->{file} || './Bayes.dat';
    $client->on(receive_message=>sub{
        my($client,$msg) = @_;
		my $content = $msg->content;
		my $sender_nick = $msg->sender->displayname;
		my $base = {};
		$base = retrieve($file) if -e $file;
		if ($content =~ m/^(记录|save)>>>(\d+)(\||,).*,(0|1){1}$/g) {
			my $qq = $2;
			$msg->allow_plugin(0);
			$content =~ s/$1>>>//g;
			$content=~s/^\s+|\s+$//g;
			$content=~s/\|/,/g;
			$qq=~s/^\s+|\s+$//g;
			return unless defined $content;
			return unless $qq;
			push @{ $base->{$qq} }, $content;
			nstore($base,$file);
			$client->reply_message($msg,"\@$sender_nick  样本记录 【 $content 】 添加成功.");
		}elsif($content =~ m/^(预测|seer)>>>(\d+)(\|[^|]+)?(\|[1-7]+)?$/g){
			$client->debug("-------------Bayes分类器--------------------");
			$msg->allow_plugin(0);
			my $number = $2;	#qq号码(唯一标识)
			my $content = $3;	#地区|天气内容
			my $time = $4;		#预测几天，为空则为1
			$number=~s/^\s+|\s+$//g;
			$content=~s/^\s+|\s+$//g;
			$content=~s/\|//g;
			$time=~s/^\s+|\s+$//g;
			$client->debug("QQ号码\$number: $number");
			$client->debug("内容\$content: $content");
			return unless defined $number;
			return unless !exists($base{$number});
			$client->debug("-------------开始分析-------------------------");
			my $recodes = $base->{$number};
			my $totals = @{$base->{$number}};#总记录数
			$client->debug("用户<$number>目前有<$totals>条历史数据");
			if ($content =~ m/,/g) {
				#说明$content为天气信息
				#查询出该用户所有的记录信息
				
			}elsif(defined $content && $content ne ""){
				#说明$content为地区,需要将$content修改为天气信息
			}else{
				#需要根据qq号获取该用户的所在地区，然后在去获取天气信息
			}
			my @next = split(/,/,$content);
			return unless scalar(@next) == 3;
			########################################
			my $result;
			my $outlook = shift @next;
			my $degree = shift @next;
			my $windy = shift @next;
			$client->debug("将要预测的数据\$outlook: ".$outlook);
			$client->debug("将要预测的数据\$degree: ".$degree);
			$client->debug("将要预测的数据\$windy: ".$windy);
			my $reply = "\@$sender_nick\n--------------Bayes分类器--------------\n";
			$reply .= "QQ号码: $number\n样本数据集: <$totals> 条\n新实例:\n\tOutlook: $outlook\n\tDegree: $degree\n\tWindy: $windy\n";
			$reply .= "--------------开始分析--------------\n";
			#开始预测
			#计算先验概率
			my @p_yes_tmp = grep {/,1$/} @$recodes;
			my @p_no_tmp = grep {/,0$/} @$recodes;
			my $p_yes_count = scalar(@p_yes_tmp);#yes的总次数
			my $p_no_count = scalar(@p_no_tmp);#no的总次数
			$client->debug("\$p_yes_count: ".$p_yes_count);
			$client->debug("\$p_no_count: ".$p_no_count);
			$reply .= "YES样本数: $p_yes_count\nNO样本数: $p_no_count\n";
			my $p_yes_pro = $p_yes_count / $totals;#yes的概率
			my $p_no_pro =  $p_no_count / $totals;#no的概率
			$client->debug("先验概率P(YES): ".$p_yes_pro);
			$client->debug("先验概率P(NO): ".$p_no_pro);
			$reply .= "先验概率P(YES): $p_yes_pro\n先验概率P(NO): $p_no_pro\n";
			#计算类条件概率
			my @p_yes = ();
			my @p_no = ();
			foreach (@p_yes_tmp) {
				push(@p_yes,encode("utf-8",$_));
			}
			foreach (@p_no_tmp) {
				push(@p_no,encode("utf-8",$_));
			}
			my @outlook_yes = grep {/^$outlook,[^,]+,[^,]+,1$/} @p_yes;
			my @outlook_no = grep {/^$outlook,[^,]+,[^,]+,0$/} @p_no;
			my @degree_yes = grep {/^[^,]+,$degree,[^,]+,1$/} @p_yes;
			my @degree_no = grep {/^[^,]+,$degree,[^,]+,0$/} @p_no;
			my @windy_yes = grep {/^[^,]+,[^,]+,$windy,1$/} @p_yes;
			my @windy_no = grep {/^[^,]+,[^,]+,$windy,0$/} @p_no;
			my $final_yes=0;
			my $final_no=0;
			if ($p_yes_count) {
				my $outlook_yes_prop = scalar(@outlook_yes) / $p_yes_count;#yes的概率
				my $degree_yes_prop = scalar(@degree_yes) / $p_yes_count;#yes的概率
				my $windy_yes_prop = scalar(@windy_yes) / $p_yes_count;#yes的概率
				if ($outlook_yes_prop && $outlook_yes_prop ne '0') {
					$client->debug("类条件概率P(Outlook=$outlook|YES): ".$outlook_yes_prop);
					$client->debug("\$final_yes1: $final_yes");
					if ($final_yes == 0) {
						$final_yes = $outlook_yes_prop;
					}else{
						$final_yes *= $outlook_yes_prop;
					}
					$client->debug("\$final_yes2: $final_yes");
				}
				if ($degree_yes_prop && $degree_yes_prop ne '0') {
					$client->debug("类条件概率P(Degree=$degree|YES): ".$degree_yes_prop);
					$client->debug("\$final_yes3: $final_yes");
					if ($final_yes == 0) {
						$final_yes = $degree_yes_prop;
					}else{
						$final_yes *= $degree_yes_prop;
					}
					$client->debug("\$final_yes4: $final_yes");
				}
				if ($windy_yes_prop && $windy_yes_prop ne '0') {
					$client->debug("类条件概率P(Windy=$windy|YES): ".$windy_yes_prop);
					$client->debug("\$final_yes5: $final_yes");
					if ($final_yes == 0) {
						$final_yes = $windy_yes_prop;
					}else{
						$final_yes *= $windy_yes_prop;
					}
					$client->debug("\$final_yes6: $final_yes");
				}
				$client->debug("\$final_yes7: $final_yes");
				if ($final_yes == 0) {
					$final_yes = $p_yes_pro;
				}else{
					$final_yes *= $p_yes_pro;
				}
				$client->debug("\$final_yes8: $final_yes");
				$reply .= "类条件概率P(Outlook=\"$outlook\"|YES): $outlook_yes_prop\n类条件概率P(Degree=\"$degree\"|YES): $degree_yes_prop\n类条件概率P(Windy=\"$windy\"|YES): $windy_yes_prop\n";
			}
			if ($p_no_count) {
				my $outlook_no_prop = scalar(@outlook_no) / $p_no_count;#no的概率
				my $degree_no_prop = scalar(@degree_no) / $p_no_count;#no的概率
				my $windy_no_prop = scalar(@windy_no) / $p_no_count;#no的概率
				if ($outlook_no_prop && $outlook_no_prop ne "0") {
					$client->debug("类条件概率P(Outlook=$outlook|NO): ".$outlook_no_prop);
					if ($final_no == 0) {
						$final_no = $outlook_no_prop;
					}else{
						$final_no *= $outlook_no_prop;
					}
				}
				if ($degree_no_prop && $degree_no_prop ne "0") {
					$client->debug("类条件概率P(Degree=$degree|NO): ".$degree_no_prop);
					if ($final_no == 0) {
						$final_no = $degree_no_prop;
					}else{
						$final_no *= $degree_no_prop;
					}
				}
				if ($windy_no_prop && $windy_no_prop ne "0") {
					$client->debug("类条件概率P(Windy=$windy|NO): ".$windy_no_prop);
					if ($final_no == 0) {
						$final_no = $windy_no_prop;
					}else{
						$final_no *= $windy_no_prop;
					}
				}
				if ($final_no == 0) {
					$final_no = $p_no_pro;
				}else{
					$final_no *= $p_no_pro;
				}
				$reply .= "类条件概率P(Outlook=\"$outlook\"|NO): $outlook_no_prop\n类条件概率P(Degree=\"$degree\"|NO): $degree_no_prop\n类条件概率P(Windy=\"$windy\"|NO): $windy_no_prop\n";
			}
			$client->debug("后验概率(YES|x): $final_yes");	
			$client->debug("后验概率(NO|x): $final_no");
			$reply .= "后验概率(YES|x): $final_yes\n后验概率(NO|x): $final_no\n";
			#分类
			if ($final_yes && $final_no) {
				if ($final_yes > $final_no) {
					$result = "YES";
				}else{
					$result = "NO";
				}
				$client->debug("预测结果\$result: ".$result);
				$reply .= "--------------分类结果--------------\n因为 $final_yes > $final_no \n所以该样本分类结果为: $result  (来自 如来助理)";
				#完成预测返回预测结果
				$client->debug($reply);
				$client->reply_message($msg,$reply);
			}
        }elsif($content =~ m/^(天气|weather)>>>/g){
			$content=~s/$1>>>//g;
			$content=~s/^\s+|\s+$//g;
			$msg->allow_plugin(0);
			if ($content !~ /[A-Za-z]+/g) {
				my $h2p = Lingua::Han::PinYin->new();
				$content = $h2p->han2pinyin($content);
			}
			$client->debug("天气: $content");
			$client->http_get("http://www.tianqihoubao.com/yubao/$content.html",{},sub{
					my $html = shift;
					return unless defined $html;
					$html = decode('gbk',$html);
					my $dom = Mojo::DOM->new($html);
					my $tr = $dom->find('div.wdetail')->[0];
					$dom = Mojo::DOM->new($tr);
					my $title = $dom->at('h1')->text;
					my @trs = $dom->find("tr")->each;
					shift @trs;
					my $info;
					my $last;
					my @reply=();
					foreach my $item (@trs) {
						$dom = Mojo::DOM->new($item);
						my $first = $dom->find("td,b")->[0]->text;
						if ($first =~ /\d{4}-\d{2}-\d{2}/g) {
							$last = $first;
							$info = $dom->find("td,b")->map("text")->join(",");
							$info =~ s/,,/,/g;
						}else{
							$info = $dom->find("td,b")->map("text")->join(",");
							$info =~ s/,,/,/g;
							$info = $last.",".$info;
						}
						$info =~ s/(\r|\n|\s)//g;
						push(@reply,$info);
					}
					if (scalar(@reply) < 1) {
						$client->reply_message($msg,"\@$sender_nick\n我只知道全国天气预报(⊙o⊙)喔. (来自 如来助理)");
					}else{
						my $reply = "$title\n".join("\n",@reply);
						$reply = "\@$sender_nick\n".encode("utf8",$reply);
						chomp($reply);
						$client->reply_message($msg,$reply);
					}
			});
		}else{
			return;
		}
	});
}
1;