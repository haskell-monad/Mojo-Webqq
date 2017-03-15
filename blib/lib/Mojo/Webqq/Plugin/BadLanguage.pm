package Mojo::Webqq::Plugin::BadLanguage;
$Mojo::Webqq::Plugin::BadLanguage::PRIORITY = 98;

=start

usage:
	撕逼吧no@伊斯兰国
	放了他@伊斯兰国
	撕逼吧(yes|no)@XXX
	放了他@XXX
	yes是带脏字的
	no是不带脏字的
=cut
use Storable qw(retrieve nstore);
our %timer_hash=();
sub call{
    my $client = shift;
    my $data = shift;
    my $file = $data->{file} || './BadLanguage.dat';
    my $base = {};
    $base = retrieve($file) if -e $file;
    my $callback = sub{
        my($client,$msg) = @_;
        return if $msg->type !~ /^message|group_message|dicsuss_message|sess_message$/;
		my $tarid;
		if ($msg->type =~ /group_message/) {
			$tarid = $msg->group->gid;
		}elsif($msg->type =~ /dicsuss_message/){
			return;
		}else{
			$tarid = "undef_";
		}
        if($msg->content =~ m/^撕逼吧(yes|no)?(@.*)/g){
			my $type = $1;
			my $name = $2;
			$name=~s/^\s+|\s+$//g;
			$type=~s/^\s+|\s+$//g;
			return unless defined $name;
			return unless !exists($timer_hash{$tarid.$name});
			$msg->allow_plugin(0);
			unless (defined $type) {
				$type = "yes";
			}
			my $len = @{$base->{$type}};
			my $id = $client->ioloop->recurring(5,sub{
				$client->reply_message($msg,$name.",你给我听着：".$base->{$type}->[int rand $len],sub{$_[1]->msg_from("bot")});
			});
			$timer_hash{$tarid.$name}=$id;
        }elsif($msg->content =~ m/^放了他(@.*)/g){
			my $name = $1;
			$name=~s/^\s+|\s+$//g;
			return unless defined $name;
			$msg->allow_plugin(0);
			$client->ioloop->remove($timer_hash{$tarid.$name});
			delete $timer_hash{$tarid.$name};
			$client->reply_message($msg,"小学生<$name>以后说话注意点!",sub{$_[1]->msg_from("bot")});
		}
    };
    $client->on(receive_message=>$callback);
    $client->on(send_message=>$callback);
	$client->on(login=>sub{undef %timer_hash;});
}
1;
#定义
#my $file = 'BadLanguage.dat';
#my $base = {};
#my $q = "no";
#$base = retrieve($file) if -e $file;
#读取
#my $len = @{$base->{$q}};
#print $len."\n";
#print $base->{$q}->[int rand $len];

#存储
#while (<DATA>) {
	#next unless /\S/;
	#push @{ $base->{$q} }, $_;
#}
#nstore($base,$file);
#__DATA__