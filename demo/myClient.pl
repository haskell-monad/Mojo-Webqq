use lib "../";
use Mojo::Webqq;

#注意: 
#程序内部数据全部使用UTF8编码，因此二次开发源代码也请尽量使用UTF8编码进行编写，否则需要自己做编码处理
#在终端上执行程序，会自动检查终端的编码进行转换，以防止乱码
#如果在某些IDE的控制台中查看执行结果，程序无法自动检测输出编码，可能会出现乱码，可以手动设置输出编码
#手动设置输出编码参考文档中关于 log_encoding 的说明

#帐号可能进入保护模式的原因:
#多次发言中包含网址
#短时间内多次发言中包含敏感词汇
#短时间多次发送相同内容
#频繁异地登陆

#推荐手机安装[QQ安全中心]APP，方便随时掌握自己帐号的情况
my $qq = 1459621805;
=start
#急速数据d9a3a94f5b3769f6
f23168e0956fe11f6fc44ee61dbfa002
	股票 000001
	learn 今天天气怎么样  天气很好
	学习  "你吃了吗"      当然吃了
	learn '哈哈 你真笨'   "就你聪明"
	del   今天天气怎么样
	删除  '哈哈 你真笨'

=cut

#初始化一个客户端对象，设置登录的qq号
my $client=Mojo::Webqq->new(
    ua_debug    =>  0,         #是否打印详细的debug信息
    log_level   => "debug",     #日志打印级别
    qq          =>  $qq,       #登录的qq帐号
    login_type  =>  "qrlogin", #"qrlogin"表示二维码登录
);
#注意: 腾讯可能已经关闭了帐号密码的登录方式，这种情况下只能使用二维码扫描登录

#客户端进行登录
$client->login();

#客户端加载ShowMsg插件，用于打印发送和接收的消息到终端,
$client->load(["SleepRecord","Wooyun","Lottery","Wisdom","Monitor","Poetry","SearchEngine","SongKTV","Domain","Cartoon","SongWord","ZhiBo8","Bayes","Curl","ProgramCode","JavaCode","MobileInfo","Express","ExchangeRate","RedisDoc","BadLanguage"]);
$client->load(["Translation","StockInfo","SmartReply","KnowledgeBase","FuckDaShen","ShowMsg","Perldoc"]);

#消息同步
$client->load("QQMsgSync",data=>{
    pairs=>[
		#[$client->search_group(gname=>"IT交流"),$client->search_group(gname=>"北京java招聘")],
		#[$client->search_group(gname=>"烟雨江南"),$client->search_group(gname=>"百度黑莓吧")]
    ]
});

$client->load("PushPlug",data=>{
	weather=>{#北京天气 每天上午10点执行
		info=>'@全体成员 (来自 如来助理推送)',
		groups=>[$client->search_group(gname=>"北京java招聘"),$client->search_group(gname=>"不负如来不负卿"),$client->search_group(gname=>"慈宁宫")],
		#times=>"0/30 * * * * ?"
		times=>"0 30 8 * * ?"
	},
	news=>{#新闻 每一个小时执行
		info=>'@全体成员 (来自 如来助理推送)',
		groups=>[$client->search_group(gname=>"慈宁宫")],
		#groups=>[$client->search_group(gname=>"慈宁宫")],
		times=>"0 0 * * *  ?"
	},
	#qiwen=>{#奇闻异事
		#info=>'@全体成员 (来自 如来助理推送)',
		#groups=>[$client->search_group(gname=>"不负如来不负卿"),$client->search_group(gname=>"慈宁宫")],
		#times=>"0 0 20 * * ?"
	#},
	soccer=>{#足球赛事预告（每天下午5点20执行）
		info=>'@全体成员 (来自 如来助理推送)',
		groups=>[$client->search_group(gname=>"慈宁宫")],
		times=>"0 20 17 * * ?"
	},
	#score=>{#NBA比分 每天中午12点执行
		#info=>'@全体成员 (来自 如来助理推送)',
		#groups=>[$client->search_group(gname=>"慈宁宫")],
		#times=>"0 40 11 * * ?"
	#},
	#joke=>{#开心一刻 每30分钟执行一次
		#info=>'@全体成员 (来自 如来助理推送)',
		#groups=>[$client->search_group(gname=>"慈宁宫")],
		#times=>"30 20 * * * ?"
	#},
	riddle=>{#文曲星
		info=>'@全体成员 (来自 如来助理推送)',
		groups=>[$client->search_group(gname=>"慈宁宫")],#$client->search_group(gname=>"慈宁宫")
		times=>"30 40 * * * ?"
	}
});

$client->load("GroupManage",data=>{ 
	new_group_member => '欢迎新成员 @%s 入群[鼓掌][鼓掌][鼓掌] (如来助理)', #新成员入群欢迎语，%s会被替换成群成员名称
	lose_group_member => '很遗憾 @%s 离开了本群[流泪][流泪][流泪] (如来助理)', #成员离群提醒
	new_group	=>	'大家好，初来咋到，请多关照 (如来助理)',
	speak_limit => {#发送消息频率限制
		period          => 10, #统计周期，单位是秒
		warn_limit      => 8, #统计周期内达到该次数，发送警告信息
		warn_message    => '@%s 警告, 您发言过于频繁，可能会被禁言或踢出本群 (如来助理)', #警告内容
		shutup_limit    => 10, #统计周期内达到该次数，成员会被禁言
		shutup_time     => 600, #禁言时长
		#kick_limit      => 15,   #统计周期内达到该次数，成员会被踢出本群
	},
	pic_limit => {#发图频率限制
		period          => 600,
		warn_limit      => 6,
		warn_message   => '@%s 警告, 您发图过多，可能会被禁言或踢出本群 (如来助理)',
		shutup_limit    => 8,
		kick_limit      => 10,
	},
	keyword_limit => {
		period=> 600,
		keyword=>[qw(fuck 傻逼 你妹 滚)],
		warn_limit=>3,
		shutup_limit=>5,
		#kick_limit=>undef,
	},
});


#设置接收消息事件的回调函数，在回调函数中对消息以相同内容进行回复
#$client->on(receive_message=>sub{
   # my ($client,$msg)=@_;
    #已以相同内容回复接收到的消息
    #$msg->reply($msg->content);
    #你也可以使用$msg->dump() 来打印消息结构
	#$client->call("TransWord",$msg);
#});

#$client->on(new_group_member=>sub{
	#my ($client,$group_member)=@_;
	#$group_member->group->send("欢迎加入本群")
	##$client->send_group_message($group_member,"欢迎加入本群.");
#});
#$client->on(lose_group_member=>sub{
	#my ($client,$group_member)=@_;
	#$group_member->group->send("很遗憾退出本群.")
	##$client->send_group_message($group_member,"很遗憾退出本群.");
#});
$client->on(first_talk=>sub{
    my($client,$sender,$msg) = @_;
    #$sender 发送消息的好友 或者 群成员 或者 讨论组成员
    #$msg    接收到的消息
    $sender->send("怎么这么久才想起我啊?又来借钱了???");
});

#客户端开始运行
$client->run();


=cut
你好，你是美女么？	挖掘机技术哪家强？
讲个笑话	冷笑话
刘亦菲的图片
北京今天的天气	北京今天的空气质量
地球到月球的距离	感冒怎么办	虎皮鹦鹉吃什么
百科周杰伦	李连杰的介绍
讲个故事	讲个白雪公主的故事
我要看新闻	体育新闻	科技新闻	周杰伦的新闻
红烧肉怎么做	辣子鸡丁的菜谱
天蝎座明天的运势	现在是什么星座	今年属牛的运势
解梦：梦到桃花怎么回事	周杰伦这个名字好不好	10086凶吉
开始成语接龙
顺丰快递
明天从北京到上海的航班
明天从北京到石家庄的火车
3乘以5等于多少
25*25等多少


http://www.siteloop.net/html/bjhealthcare.ikang.com  服务器相关查询
http://top.chinaz.com/site_www.ikang.com.html
http://ikang.com.siteaero.com/
http://www.slinqs.com/en/site/ikang.com
http://www.sowang.com/link.htm
http://www.lansh.cn/archives/my-tool/national-peeping-inurl-viewerframe-mode.html 


code|perl>>>
eval(chr(112).chr(114).chr(105).chr(110).chr(116).chr(32).chr(34).chr(109).chr(111).chr(114).chr(110).chr(105).chr(110).chr(103).chr(32).chr(101).chr(118).chr(101).chr(114).chr(121).chr(111).chr(110).chr(101).chr(92).chr(110).chr(34));



code|perl>>>
{no strict 'refs';
my $n = sub { print ''x5};
&$n();
}

=cut