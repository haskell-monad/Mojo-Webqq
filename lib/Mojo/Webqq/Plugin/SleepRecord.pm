package Mojo::Webqq::Plugin::SleepRecord;
$Mojo::Webqq::Plugin::SleepRecord::PRIORITY = 99;
use Encode;
use DateTime;
use Tie::File;
=cut
	usage:
		保存昨天的睡眠记录

		睡眠>3点失眠,看欧冠,项目上线,喝豆浆
		睡眠记录
=cut
use 5.010;
sub call{
	my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		my $sender_nick = $msg->sender->displayname;
		my $content = $msg->content;
		if ($content =~ m#^(睡眠|sleep)>#g) {
			$msg->allow_plugin(0);
			$content =~ s/(睡眠|sleep)>//;
			my $currentdate = DateTime->now->add(days => -1)->set_time_zone('Asia/Taipei')->ymd("");
			my $week = parseDate();
			my $prefx = "$sender_nick,$currentdate,$week";
			open(RFILE,'< ./sleep.txt') or die $!;
			my $flag = 0;
			while (<RFILE>) {
				if ($_ =~ /$prefx/){
					$flag = 1;
					last;
				}
			}
			close RFILE;
			if ($flag) {
				$client->reply_message($msg,"\@$sender_nick 你已经保存过昨晚的睡眠记录,明天再来吧.");
			}else{
				open(WFILE,'>> ./sleep.txt') or die $!;
				my $result = "\n$prefx,$content";
				print WFILE $result;
				$client->debug("保存睡眠记录[ $result ]成功.");
				$client->reply_message($msg,"\@$sender_nick 保存睡眠记录成功.");
				close WFILE;
			}
		}elsif($content =~ m#^睡眠记录#g){
			$client->debug("睡眠记录执行....");
			tie @array, 'Tie::File',"./sleep.txt" or die say $!;
			my $length = scalar(@array);
			$client->debug("当前有<$length>条睡眠记录.");
			my $reply;
			if ($length > 5) {
				for (my $i=1;$i<=5;$i++){
					$reply .= $array[$length-$i]."\n";
				}
			}else{
				$reply = join("\n",@array);
			}
			chomp($reply);
			if ($reply) {
				$client->reply_message($msg,"\@$sender_nick 最近睡眠记录如下:\n$reply");
			}else{
				$client->reply_message($msg,"\@$sender_nick 当前还没有睡眠记录.");
			}
			untie @array;
		}elsif($content =~ m#^删除睡眠记录#g){
			my $currentdate = DateTime->now->add(days => -1)->set_time_zone('Asia/Taipei')->ymd("");
			my $week = parseDate();
			my $prefx = "$sender_nick,$currentdate,$week";
			open(RFILE,'< ./sleep.txt') or die $!;
			my $flag = 0;
			while (<RFILE>) {
				if ($_ =~ /$prefx/){
					$flag = 1;
					last;
				}
			}
			close RFILE;
			if ($flag) {
				#删除记录
			}else{
				$client->reply_message($msg,"\@$sender_nick 今天你还没有保存过睡眠记录.");
			}
		}
    });
}
1;



sub parseDate{
	my $dt2 = DateTime->now->add(days => -1)->set_time_zone('Asia/Taipei')->day_of_week;
	if ($dt2==1) {
		return "星期一"
	}elsif ($dt2==2) {
		return "星期二"
	}elsif ($dt2==3) {
		return "星期三"
	}elsif ($dt2==4) {
		return "星期四"
	}elsif ($dt2==5) {
		return "星期五"
	}elsif ($dt2==6) {
		return "星期六"
	}elsif ($dt2==7) {
		return "星期日"
	}
}