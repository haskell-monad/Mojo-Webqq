package Mojo::Webqq::Plugin::SongWord;
$Mojo::Webqq::Plugin::SongWord::PRIORITY = 99;
use POSIX qw(strftime);
use HTML::Query 'Query';
use Encode;
=cut
	usage:
		1是一行
		2是换行
		3是拆分发送多条消息
		song(1):分手快乐
		song(2):分手快乐
		song(3):分手快乐
=cut
sub call{
	my $client = shift;
	my $data = shift;
	$client->on(receive_message=>sub{
		my($client,$msg)=@_;
		if ($msg->content =~ m#^song\(([1,2,3]?)\)\s*:(.*)#g) {
			$msg->allow_plugin(0);
			my $sender_nick = $msg->sender->displayname;
			my $lrc_type = $1;#歌词展示类型
			my $song_name = $2;#歌曲名称
			my $content;
			my $url = "http://music.hao123.com/search/lrc";
			$client->http_get($url,form=>{key=>decode("utf8",$song_name)},sub{
				my $data = shift;
				return unless defined $data;
				my $query = Query(text => $data);
				my @elems = $query->query('p#lyricCont-0')->as_trimmed_text;
				my $scalar = @elems;
				if ($scalar) {
					$content = $elems[0];
					if (defined $content) {
						if ($lrc_type eq '2') {
							$content =~ s/ /\n/g;
							if(count_lines($content) > 20){
								$content  = join "\n",(split /\r?\n/,$content,21)[0..19];
								$content .= "\n(已截断)来自 如来助理";
							}
						}elsif ($lrc_type eq '1'){
								if (length(Encode::decode("utf8",$content)) > 200) {
									$content = substr(Encode::decode("utf8",$content),0,200)."\n".Encode::decode("utf8","(已截断)来自 如来助理");
								}
						}elsif ($lrc_type eq '3') {
							$content =~ s/ /\n/g;
							#if(count_lines($content) > 20){
								#$content  = join "\n",(split /\r?\n/,$content,21)[0..19];
								#$content .= "\n(已截断)来自 如来助理";
							#}
							my $lines = count_lines($content) > 20 ? 20 : count_lines($content);
							my $cnt = "\@$sender_nick 歌曲《 $song_name 》歌词如下(来自 如来助理):\n";
							my $last = 0;
							$client->debug("歌曲《 $song_name 》目前有 $lines 行.");
							for (0..$lines) {
								if ($_ % 3 == 0) {
									$cnt .=	join "\n",(split /\r?\n/,$content,21)[$last..$_];
									if (defined $cnt && $cnt ne '') {
										$client->reply_message($msg,$cnt);
									}
									$last = $_ + 1;
									$cnt = undef;
								}
							}
							return
						}else{
							return
						}
					}
				}else{
					$content = "不好意思，没有找到歌曲《$song_name》.换首歌曲试试吧.";
				}
				$client->debug("歌曲: $lrc_type:$song_name\n");
				if ($lrc_type eq '1') {
					$client->reply_message($msg,"\@$sender_nick 歌曲《 $song_name 》歌词如下:\n".Encode::encode("utf8",$content));
				}else{
					$client->reply_message($msg,"\@$sender_nick 歌曲《 $song_name 》歌词如下:\n".$content);
				}
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