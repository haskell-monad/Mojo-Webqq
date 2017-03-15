package Mojo::Webqq::Plugin::SparkShell;
$Mojo::Webqq::Plugin::SparkShell::PRIORITY = 1;
use File::Basename;
use File::Path;
=start
usage:
	spark>>>
	sc.textFile("").map();
	import java.io._
		将执行的结果写入文件;
		perl读取文件获取计算结果发送消息到qq群;
=cut
use Sys::Cmd qw/run spawn/;
our $spark_bin = "C:\\Users\\Administrator\\Desktop\\spark\\bin";

#my @cmd = ("$spark_bin\\spark-shell.cmd");
#my $proc = spawn( @cmd, {encoding => 'iso-8859-3'} );

#while (my $line = $proc->stdout->getline) {
    #$proc->stdin->print("thanks");
	#print $line;
#}
#system("start $spark_bin\\spark-shell.cmd");
#system("val id = 100");
sub call{
    my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		$msg->allow_plugin(0);
		my $tmp_code_dir = 'd:\\_spark_shell\\';#创建临时存放code的目录
		mkpath($tmp_code_dir);#创建临时存放code的目录
		my $content = $msg->content;
		if ($content =~ m/^spark>>>/g) {
			system("start $spark_bin");
		}
		if ($class_name && $content) {
			my $reply = undef;
			
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
				$reply = "编译时出现错误，错误信息如下---->: \n@$rtn\n";
			}else{
				my $res = eval {
					my $command = "java -classpath $tmp_code_dir $class_name";
					$client->debug("执行命令: $command\n");
					my @rs = `$command`;
					return \@rs;
				};
				if (scalar($res)) {
					$client->debug("运行结果---->: \n@$res\n");
					$reply = "运行结果---->: \n@$res\n";
				}
			}
			$client->reply_message($msg,$reply);
			my $sum = unlink glob "$tmp_code_dir$class_name.*";
			$client->debug("清理了 $sum 个生成的临时文件\n");	
		}
	});
}
1;
