package Mojo::Webqq::Plugin::Curl;
$Mojo::Webqq::Plugin::Curl::PRIORITY = 98;
use Encode;
use JSON;
=cut
	usage: 
		curl -G  http://hostname.com
		curl -d/--data "param1=value1&param2=value"  http://hostname.com
		curl --data-urlencode "value 1" http://hostname.com
		curl -I -X DELETE https://api.github.cim 通过 -X 选项指定其它协议
		curl -x proxysever.test.com:3128 http://google.co.in	指定代理主机和端口
		curl -u username:password URL 
		curl -L http://www.google.com -L选项进行重定向
		curl -D sugarcookies http://localhost/sugarcrm/index.php 保存与使用网站cookie信息
		curl -b sugarcookies http://localhost/sugarcrm/index.php 使用上次保存的cookie信息
		curl --data @filename https://github.api.com/authorizations
		
		------以下都是不支持的---------
		curl --form "fileupload=@filename.txt" http://hostname/resource 上传文件
		curl -u ftpuser:ftppass -T "{file1,file2}" ftp://ftp.testserver.com
		curl -u ftpuser:ftppass -O ftp://ftp_server/public_html/ 列出public_html下的所有文件夹和文件
		curl -u ftpuser:ftppass -O ftp://ftp_server/public_html/xss.php 下载xss.php文件
		curl -z 21-Dec-11 http://www.example.com/yy.html
		curl --limit-rate 1000B -O http://www.gnu.org/software/gettext/manual/gettext.html
		curl -O URL1 -O URL2
		curl -O http://www.gnu.org/software/gettext/manual/gettext.html 当文件在下载完成之前结束该进程
		curl -C - -O http://www.gnu.org/software/gettext/manual/gettext.html 通过添加-C选项继续对该文件进行下载，已经下载过的文件不会被重新下载
=cut

#支持的参数
my %hash = (
	"-G" => "",
	"-g" => "",
	"--http1.0" => "",
	"-d" => "",
	"-I" => "",
	"-i" => "",
	"-X" => "",
	"-x" => "",
	"-u" => "",
	"-L" => "",
	"-E" => "",
	"-e" => "",
	"-D" => "",
	"-B" => "",
	"-b" => "",
	"--data" => "",
	"-f" => "",
	"-P" => "",
	"-H" => "",
	"-s" => "",
	"-S" => "",
	"-t" => "",
	"-V" => "",
	"-w" => "",
	"-R" => "",
	"-A" => "",
);
sub call{
    my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		if ($msg->content =~ m/^curl/) {
			$msg->allow_plugin(0);
			my $content = $msg->content;
			my $reply;
			my $split = 10;
			$client->debug("curl content: $content\n");
			if ($content =~ m/--line\s+(\d+)/g) {
				$split = $1;
				$content =~ s/--line\s+\d+//g;
				$split=~s/^\s+|\s+$//g;
			}elsif($content =~ m/--line/g){
				$content =~ s/--line//g;
			}
			$client->debug("curl 保留<$split>行\n");
			my @a = $content =~ m/-{1,2}[a-zA-Z0-9\.-]+/g;
			foreach my $i (@a) {
				$i=~s/^\s+|\s+$//g;
				$client->debug("切分出curl命令选项: $i\n");
				if (!exists($hash{$i})) {
					$content =~ s/$i\s+([a-zA-z0-9\.:-\\\/]+)\s+|$i/ /g;
				}
			}
			$content=~s/^\s+|\s+$//g;
			$content .= " --connect-timeout 5 -m 5 -s";#连接超时时间用 --connect-timeout 参数来指定，数据传输的最大允许时间用 -m
			my $re = qx($content);
			my $sender_nick = $msg->sender->displayname;
			if ($re) {
				eval{
					my $json = to_json(from_json($re),{pretty => 1});
					my $to_json;
					if($split && count_lines($json) > $split){
						$to_json  = join "\n",(split /\r?\n/,$json,$split+1)[0..$split-1];
					}
					$reply = $to_json;
				};
				if ($@) {
					$reply = $re;
				}
				chomp($reply);
				if ($reply) {
					my $eval_reply = "\@$sender_nick curl执行结果如下:\n$reply";
					eval{
						$client->reply_message($msg,$eval_reply);
						$client->debug("\n\$eval_reply:\n $eval_reply");
					};
					if ($@) {
						$reply = "\@$sender_nick curl执行结果如下:\n".(encode("utf8",$reply));
						$client->reply_message($msg,$reply);
					}
				}
			}else{
				$client->reply_message($msg,"\@$sender_nick 逗比,还能不能愉快的玩耍了,给你本《葵花宝典》,先去练习下吧.\nhttp://www.cnblogs.com/davidwang456/p/4266867.html\nhttp://www.cnblogs.com/gbyukg/p/3326825.html");
			}
		}
	});
}
1;

sub count_lines{
    my $data = shift;
    my $count =()=$data=~/\r?\n/g;
    return $count++;
}

#my $re = '{"errNum":0,"retMsg":"success","retData":{"cityName":"\u5317\u4eac","provinceName":"\u5317\u4eac","cityCode":"101010100","zipCode":"100000","telAreaCode":"010"}}';
#my $json = to_json(from_json($re),{pretty => 1});
#print encode("utf8",$json);
