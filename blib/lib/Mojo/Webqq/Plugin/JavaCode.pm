package Mojo::Webqq::Plugin::JavaCode;
$Mojo::Webqq::Plugin::JavaCode::PRIORITY = 100;
use POSIX qw(strftime);
use File::Basename;
use File::Path;
=cut
	public class Test {
		public static void main(String args[]){
			for(int i=1;i<=9;i++){
				for(int j=1;j<=i;j++){
					System.out.print(j+"*"+i+"="+i*j+"\t");
				}
				System.out.println();
			}
		}
	}

	java>>>
		
=cut
my $tmp_code_dir = 'd:\\java_code_tmp_dir\\';#创建临时存放code的目录
sub call{
    my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		$msg->allow_plugin(0);
		my $class_name = undef;
		my $filename = undef;
		my $sender_nick = $msg->sender->displayname;
		my $content = $msg->content;
		if ($content =~ m/public\s+class\s+([\w]+)\s*\{/g) {
			$class_name = $1;#类名
			chomp $class_name;
		}elsif ($content =~ m/java>>>/g) {
			$class_name = "Test";#类名
			$content =~ s/java>>>//g;
			$content = "import java.util.*;\n public class $class_name {\n	public static void main(String args[]){\n".($content)."\n}\n}";
		}
		if ($class_name && $content) {
			my $reply = undef;
			mkpath($tmp_code_dir);#创建临时存放code的目录
			my $filename = "$tmp_code_dir$class_name.java";#文件名
			$client->debug("获取到class文件名为: $filename\n");
			unless (open(CODE,"> $filename")) {
				die ("cannot open input file $filename : $!\n");
			}
			$client->debug("codes:\n".$content);
			print CODE $content;
			close(CODE);
			my $rtn = eval {
				my $command = "javac $filename 2>&1";
				$client->debug("执行编译命令: $command\n");
				my @rs = `$command`;
				return \@rs;
			};
			if (scalar(@$rtn)) {
				$reply = "编译时出现错误，错误信息如下: \n@$rtn";
			}else{
				my $res = eval {
					my $command = "java -classpath $tmp_code_dir $class_name";
					$client->debug("执行命令: $command\n");
					my @rs = `$command`;
					return \@rs;
				};
				if (scalar($res)) {
					$client->debug("java运行结果: \n@$res\n");
					$reply = "@$res";
				}
			}
			$client->reply_message($msg,"\@$sender_nick 执行java结果如下:\n$reply");
			my $sum = unlink glob "$tmp_code_dir$class_name.*";
			$client->debug("清理了 $sum 个生成的临时文件\n");	
		}
	});
}
1;
