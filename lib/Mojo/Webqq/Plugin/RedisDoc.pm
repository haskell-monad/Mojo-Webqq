package Mojo::Webqq::Plugin::RedisDoc;
$Mojo::Webqq::Plugin::RedisDoc::PRIORITY = 98;
use POSIX qw(strftime);
use File::Basename;
use File::Path;
use Mojo::DOM;
=cut
	>redis --list/l
		key
		string
	>redis command --list/l
		DEL
		DUMP
		EXISTS
	>redis key DEL --help/--h
		命令: MOVE key db
		说明: 将key对应的数字减decrement。如果key不存在，操作之前，key就会被置为0。如果key的value类型错误或者是个不能表示成数字的字符串，就返回错误。
		这个操作最多支持64位有符号的正型数字。
		返回值: 返回一个数字:减少之后的value值。
		demo:
			redis> SET mykey "10"
				OK
			redis> DECRBY mykey 5
				(integer) 5
			redis> 
=cut
my %hash = (
	"key" => "key",
	"string" => "string",
	"hash" => "hash",
	"list" => "list",
	"set" => "set",
	"sorted_set" => "sorted_set",
	"pub_sub" => "pub_sub",
	"transaction" => "transaction",
	"script" => "script",
	"connection" => "connection",
	"server" => "server",
	"topic" => "topic",
);
my $redisapi = "http://doc.redisfans.com/";

our %commonds = ();#命令的hash

sub call{
    my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		my $sender_nick = $msg->sender->displayname;
		my $reply;
		if ($msg->content =~ m/^>redis\s+[\-]{2}(list|l){1}$/g) {
			$msg->allow_plugin(0);
			$reply = "\@$sender_nick redis支持的命令列表:\n";
			$reply .= join("\n",keys %hash);
			$reply .= "\n您可以使用: >redis command --list/l 继续查看相关命令";
			$client->reply_message($msg,$reply);
		}elsif ($msg->content =~ m/^>redis\s+([A-Za-z_]+)\s+[\-]{2}(list|l){1}$/g) {
			$msg->allow_plugin(0);
			my $command = $1;
			$command=~s/^\s+|\s+$//g;
			return unless $command;
			$client->http_get("$redisapi$command/index.html",{},sub{
				my $data = shift;
				return unless defined $data;
				my $dom = Mojo::DOM->new($data);
				my @commands = $dom->find('li.toctree-l1 a.reference')->each;#获取所有的子命令
				$client->debug(join("\n",@commands));
				foreach my $item (@commands) {
					next if $item->attr("href") =~ m/\.html#/g;
					my $text = lc($item->text);
					$commonds{"$command$text"} = $item->attr("href");
					$reply .= $item->text."\n";
				}
				$reply = "\@$sender_nick redis>".$command." 命令列表:\n".$reply;
				$reply .= "您可以使用: >redis $command [command] --help/h 查看相关命令的详细信息";
				$client->reply_message($msg,$reply);
			});
		}elsif($msg->content =~ m/^>redis\s+([A-Za-z_]+)\s+([A-Za-z_\/]+)\s+[\-]{2}(help|h){1}$/g){
			$msg->allow_plugin(0);
			my $module = lc($1);
			my $command = lc($2);
			$module=~s/^\s+|\s+$//g;
			$command=~s/^\s+|\s+$//g;
			return unless $module;
			return unless $command;
			my $url = $commonds{"$module$command"};
			unless ($url) {
				$client->reply_message($msg,"请先使用 >redis $module --list");
				return;
			}
			$url = "$redisapi$module/$url";
			$client->http_get($url,{},sub{
				my $data = shift;
				return unless defined $data;
				my $dom = Mojo::DOM->new($data);
				my $detail_command = $dom->find('p > strong')->[0]->text;#获取到命令
				my @detail_p = $dom->find('div.section > p')->each;
				shift @detail_p;
				$reply = "\@$sender_nick redis>".$module.">$command 命令使用说明:\n详情:$url\n";
				$reply .= "命令:\n\t$detail_command\n说明:\n\t";
				foreach my $item (@detail_p) {
					$reply .= $item->all_text."\n\t";
				}
				$reply =~ s/\s$//g;
				my @return_p = $dom->find('dl.docutils > dd')->each;
				if (scalar(@return_p) > 0) {
					$reply .= "返回值:\n\t".@return_p[-1]->all_text."\n";
				}
				my @pre_p = $dom->find('div.highlight-python > pre')->each;
				if(scalar(@pre_p) > 0){
					my $demo_p = $dom->find('div.highlight-python > pre')->[0]->all_text;
					$reply .= "使用例子:\n".$demo_p."\n";
				}
				$client->reply_message($msg,$reply);
			});
		}else{
			return;
		}
	});
}
1;
#my $dom = Mojo::DOM->new('<div class="section" id="del"><span id="id1"></span><h1>DEL<a class="headerlink" href="#del" title="Permalink to this headline">¶</a></h1><p>DEL key [key ...]</p><p>删除给定的一个或多个 <tt class="docutils literal"><span class="pre">key</span></tt> 。</p><p>被删除 <tt class="docutils literal"><span class="pre">key</span></tt> 的数量。</p></div>');
#my @detail_p = $dom->find('div.section > p')->each; 
#print "返回值:\n\t".@detail_p[-1]->all_text."\n";
#foreach my $item (@detail_p) {
	#print $item->all_text."\n";
#}
#my @commands = $dom->find("li.toctree-l1  a.reference")->each;#获取所有的子命令
#foreach my $item (@commands) {
	#print $item->text.$item->attr("href")."\n";
#}
