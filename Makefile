# This Makefile is for the Mojo::Webqq extension to perl.
#
# It was generated automatically by MakeMaker version
# 7.04 (Revision: 70400) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: ()
#

#   MakeMaker Parameters:

#     ABSTRACT => q[A Smartqq Client Framework base on Mojolicious]
#     AUTHOR => [q[sjdy521 <sjdy521@163.com>]]
#     BUILD_REQUIRES => {  }
#     CONFIGURE_REQUIRES => {  }
#     DISTNAME => q[Mojo-Webqq]
#     LICENSE => q[perl]
#     META_MERGE => { meta-spec=>{ version=>q[2] }, resources=>{ repository=>{ type=>q[git], url=>q[git://github.com/sjdy521/Mojo-Webqq.git], web=>q[https://github.com/sjdy521/Mojo-Webqq] } } }
#     NAME => q[Mojo::Webqq]
#     PREREQ_PM => { Encode::Locale=>q[0], IO::Socket::SSL=>q[1.94], Mojolicious=>q[6.11], Time::HiRes=>q[0], Time::Piece=>q[0], Time::Seconds=>q[0] }
#     TEST_REQUIRES => {  }
#     VERSION_FROM => q[lib/Mojo/Webqq.pm]
#     clean => { FILES=>q[Mojo-Webqq-* MANIFEST] }
#     dist => { COMPRESS=>q[gzip -9f], SUFFIX=>q[gz] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via D:/myapp/Strawberry/perl/lib/Config.pm).
# They may have been overridden via Makefile.PL or on the command line.
AR = ar
CC = gcc
CCCDLFLAGS =  
CCDLFLAGS =  
DLEXT = xs.dll
DLSRC = dl_win32.xs
EXE_EXT = .exe
FULL_AR = 
LD = g++
LDDLFLAGS = -mdll -s -L"D:\myapp\STRAWB~1\perl\lib\CORE" -L"D:\myapp\STRAWB~1\c\lib"
LDFLAGS = -s -L"D:\myapp\STRAWB~1\perl\lib\CORE" -L"D:\myapp\STRAWB~1\c\lib"
LIBC = 
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = MSWin32
OSVERS = 6.3
RANLIB = rem
SITELIBEXP = D:\myapp\STRAWB~1\perl\site\lib
SITEARCHEXP = D:\myapp\STRAWB~1\perl\site\lib
SO = dll
VENDORARCHEXP = D:\myapp\STRAWB~1\perl\vendor\lib
VENDORLIBEXP = D:\myapp\STRAWB~1\perl\vendor\lib


# --- MakeMaker constants section:

# Get dmake to read long commands like PM_TO_BLIB
MAXLINELENGTH = 800000

AR_STATIC_ARGS = cr
DIRFILESEP = \\
DFSEP = $(DIRFILESEP)
NAME = Mojo::Webqq
NAME_SYM = Mojo_Webqq
VERSION = 1.6.7
VERSION_MACRO = VERSION
VERSION_SYM = 1_6_7
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 1.6.7
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
INST_ARCHLIB = blib\arch
INST_SCRIPT = blib\script
INST_BIN = blib\bin
INST_LIB = blib\lib
INST_MAN1DIR = blib\man1
INST_MAN3DIR = blib\man3
MAN1EXT = 1
MAN3EXT = 3
INSTALLDIRS = site
DESTDIR = 
PREFIX = $(SITEPREFIX)
PERLPREFIX = D:\myapp\STRAWB~1\perl
SITEPREFIX = D:\myapp\STRAWB~1\perl\site
VENDORPREFIX = D:\myapp\STRAWB~1\perl\vendor
INSTALLPRIVLIB = D:\myapp\STRAWB~1\perl\lib
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = D:\myapp\STRAWB~1\perl\site\lib
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = D:\myapp\STRAWB~1\perl\vendor\lib
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = D:\myapp\STRAWB~1\perl\lib
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = D:\myapp\STRAWB~1\perl\site\lib
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = D:\myapp\STRAWB~1\perl\vendor\lib
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = D:\myapp\STRAWB~1\perl\bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = D:\myapp\STRAWB~1\perl\site\bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = D:\myapp\STRAWB~1\perl\bin
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = D:\myapp\STRAWB~1\perl\bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLSITESCRIPT = D:\myapp\STRAWB~1\perl\site\bin
DESTINSTALLSITESCRIPT = $(DESTDIR)$(INSTALLSITESCRIPT)
INSTALLVENDORSCRIPT = D:\myapp\STRAWB~1\perl\bin
DESTINSTALLVENDORSCRIPT = $(DESTDIR)$(INSTALLVENDORSCRIPT)
INSTALLMAN1DIR = none
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = $(INSTALLMAN1DIR)
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = $(INSTALLMAN1DIR)
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = none
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = $(INSTALLMAN3DIR)
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = $(INSTALLMAN3DIR)
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB = D:\myapp\STRAWB~1\perl\lib
PERL_ARCHLIB = D:\myapp\STRAWB~1\perl\lib
PERL_ARCHLIBDEP = D:\myapp\STRAWB~1\perl\lib
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = Makefile.old
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = D:\myapp\STRAWB~1\perl\lib\CORE
PERL_INCDEP = D:\myapp\STRAWB~1\perl\lib\CORE
PERL = "D:\myapp\Strawberry\perl\bin\perl.exe"
FULLPERL = "D:\myapp\Strawberry\perl\bin\perl.exe"
ABSPERL = $(PERL)
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
ABSPERLRUN = $(ABSPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
PERL_CORE = 0
PERM_DIR = 755
PERM_RW = 644
PERM_RWX = 755

MAKEMAKER   = D:/myapp/Strawberry/perl/lib/ExtUtils/MakeMaker.pm
MM_VERSION  = 7.04
MM_REVISION = 70400

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
MAKE = dmake
FULLEXT = Mojo\Webqq
BASEEXT = Webqq
PARENT_NAME = Mojo
DLBASE = $(BASEEXT)
VERSION_FROM = lib/Mojo/Webqq.pm
OBJECT = 
LDFROM = $(OBJECT)
LINKTYPE = dynamic
BOOTDEP = 

# Handy lists of source code files:
XS_FILES = 
C_FILES  = 
O_FILES  = 
H_FILES  = 
MAN1PODS = 
MAN3PODS = 

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIBDEP)$(DFSEP)Config.pm $(PERL_INCDEP)$(DFSEP)config.h

# Where to build things
INST_LIBDIR      = $(INST_LIB)\Mojo
INST_ARCHLIBDIR  = $(INST_ARCHLIB)\Mojo

INST_AUTODIR     = $(INST_LIB)\auto\$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)\auto\$(FULLEXT)

INST_STATIC      = 
INST_DYNAMIC     = 
INST_BOOT        = 

# Extra linker info
EXPORT_LIST        = $(BASEEXT).def
PERL_ARCHIVE       = $(PERL_INC)\libperl520.a
PERL_ARCHIVEDEP    = $(PERL_INCDEP)\libperl520.a
PERL_ARCHIVE_AFTER = 


TO_INST_PM = lib/Mojo/Webqq.pm \
	lib/Mojo/Webqq.pod \
	lib/Mojo/Webqq/Base.pm \
	lib/Mojo/Webqq/Cache.pm \
	lib/Mojo/Webqq/Client.pm \
	lib/Mojo/Webqq/Client/Cron.pm \
	lib/Mojo/Webqq/Client/Remote/_check_sig.pm \
	lib/Mojo/Webqq/Client/Remote/_check_verify_code.pm \
	lib/Mojo/Webqq/Client/Remote/_cookie_proxy.pm \
	lib/Mojo/Webqq/Client/Remote/_get_group_pic.pm \
	lib/Mojo/Webqq/Client/Remote/_get_img_verify_code.pm \
	lib/Mojo/Webqq/Client/Remote/_get_offpic.pm \
	lib/Mojo/Webqq/Client/Remote/_get_qrlogin_pic.pm \
	lib/Mojo/Webqq/Client/Remote/_get_vfwebqq.pm \
	lib/Mojo/Webqq/Client/Remote/_login1.pm \
	lib/Mojo/Webqq/Client/Remote/_login2.pm \
	lib/Mojo/Webqq/Client/Remote/_prepare_for_login.pm \
	lib/Mojo/Webqq/Client/Remote/_recv_message.pm \
	lib/Mojo/Webqq/Client/Remote/_relink.pm \
	lib/Mojo/Webqq/Client/Remote/change_state.pm \
	lib/Mojo/Webqq/Client/Remote/logout.pm \
	lib/Mojo/Webqq/Discuss.pm \
	lib/Mojo/Webqq/Discuss/Member.pm \
	lib/Mojo/Webqq/Friend.pm \
	lib/Mojo/Webqq/Group.pm \
	lib/Mojo/Webqq/Group/Member.pm \
	lib/Mojo/Webqq/Log.pm \
	lib/Mojo/Webqq/Message.pm \
	lib/Mojo/Webqq/Message/Base.pm \
	lib/Mojo/Webqq/Message/Emoji.pm \
	lib/Mojo/Webqq/Message/Face.pm \
	lib/Mojo/Webqq/Message/Queue.pm \
	lib/Mojo/Webqq/Message/Recv/DiscussMessage.pm \
	lib/Mojo/Webqq/Message/Recv/GroupMessage.pm \
	lib/Mojo/Webqq/Message/Recv/Message.pm \
	lib/Mojo/Webqq/Message/Recv/SessMessage.pm \
	lib/Mojo/Webqq/Message/Recv/StateMessage.pm \
	lib/Mojo/Webqq/Message/Remote/_get_sess_sig.pm \
	lib/Mojo/Webqq/Message/Remote/_send_discuss_message.pm \
	lib/Mojo/Webqq/Message/Remote/_send_group_message.pm \
	lib/Mojo/Webqq/Message/Remote/_send_message.pm \
	lib/Mojo/Webqq/Message/Remote/_send_sess_message.pm \
	lib/Mojo/Webqq/Message/Send/DiscussMessage.pm \
	lib/Mojo/Webqq/Message/Send/GroupMessage.pm \
	lib/Mojo/Webqq/Message/Send/Message.pm \
	lib/Mojo/Webqq/Message/Send/SessMessage.pm \
	lib/Mojo/Webqq/Message/Send/Status.pm \
	lib/Mojo/Webqq/Message/XMLescape.pm \
	lib/Mojo/Webqq/Model.pm \
	lib/Mojo/Webqq/Model/Base.pm \
	lib/Mojo/Webqq/Model/Remote/_get_discuss_info.pm \
	lib/Mojo/Webqq/Model/Remote/_get_discuss_list_info.pm \
	lib/Mojo/Webqq/Model/Remote/_get_friend_info.pm \
	lib/Mojo/Webqq/Model/Remote/_get_friends_state.pm \
	lib/Mojo/Webqq/Model/Remote/_get_group_info.pm \
	lib/Mojo/Webqq/Model/Remote/_get_group_info_ext.pm \
	lib/Mojo/Webqq/Model/Remote/_get_group_list_info.pm \
	lib/Mojo/Webqq/Model/Remote/_get_group_list_info_ext.pm \
	lib/Mojo/Webqq/Model/Remote/_get_recent_info.pm \
	lib/Mojo/Webqq/Model/Remote/_get_user_friends.pm \
	lib/Mojo/Webqq/Model/Remote/_get_user_friends_ext.pm \
	lib/Mojo/Webqq/Model/Remote/_get_user_info.pm \
	lib/Mojo/Webqq/Model/Remote/_invite_friend.pm \
	lib/Mojo/Webqq/Model/Remote/_kick_group_member.pm \
	lib/Mojo/Webqq/Model/Remote/_remove_group_admin.pm \
	lib/Mojo/Webqq/Model/Remote/_set_group_admin.pm \
	lib/Mojo/Webqq/Model/Remote/_set_group_member_card.pm \
	lib/Mojo/Webqq/Model/Remote/_shutup_group_member.pm \
	lib/Mojo/Webqq/Model/Remote/get_qq_from_id.pm \
	lib/Mojo/Webqq/Model/Remote/get_single_long_nick.pm \
	lib/Mojo/Webqq/Plugin.pm \
	lib/Mojo/Webqq/Plugin/BadLanguage.pm \
	lib/Mojo/Webqq/Plugin/Bayes.pm \
	lib/Mojo/Webqq/Plugin/Cartoon.pm \
	lib/Mojo/Webqq/Plugin/Curl.pm \
	lib/Mojo/Webqq/Plugin/Domain.pm \
	lib/Mojo/Webqq/Plugin/ExchangeRate.pm \
	lib/Mojo/Webqq/Plugin/Express.pm \
	lib/Mojo/Webqq/Plugin/FuckDaShen.pm \
	lib/Mojo/Webqq/Plugin/GroupManage.pm \
	lib/Mojo/Webqq/Plugin/IRCShell.pm \
	lib/Mojo/Webqq/Plugin/JavaCode.pm \
	lib/Mojo/Webqq/Plugin/KnowledgeBase.pm \
	lib/Mojo/Webqq/Plugin/Lottery.pm \
	lib/Mojo/Webqq/Plugin/MobileInfo.pm \
	lib/Mojo/Webqq/Plugin/Monitor.pm \
	lib/Mojo/Webqq/Plugin/MsgSync.pm \
	lib/Mojo/Webqq/Plugin/Openqq.pm \
	lib/Mojo/Webqq/Plugin/Perlcode.pm \
	lib/Mojo/Webqq/Plugin/Perldoc.pm \
	lib/Mojo/Webqq/Plugin/Poetry.pm \
	lib/Mojo/Webqq/Plugin/PostImgVerifycode.pm \
	lib/Mojo/Webqq/Plugin/PostQRcode.pm \
	lib/Mojo/Webqq/Plugin/ProgramCode.pm \
	lib/Mojo/Webqq/Plugin/PushPlug.pm \
	lib/Mojo/Webqq/Plugin/QQMsgSync.pm \
	lib/Mojo/Webqq/Plugin/Questions.pm \
	lib/Mojo/Webqq/Plugin/RedisDoc.pm \
	lib/Mojo/Webqq/Plugin/SearchEngine.pm \
	lib/Mojo/Webqq/Plugin/ShowMsg.pm \
	lib/Mojo/Webqq/Plugin/SleepRecord.pm \
	lib/Mojo/Webqq/Plugin/SmartReply.pm \
	lib/Mojo/Webqq/Plugin/SongKTV.pm \
	lib/Mojo/Webqq/Plugin/SongWord.pm \
	lib/Mojo/Webqq/Plugin/SparkShell.pm \
	lib/Mojo/Webqq/Plugin/StockInfo.pm \
	lib/Mojo/Webqq/Plugin/Translation.pm \
	lib/Mojo/Webqq/Plugin/Wisdom.pm \
	lib/Mojo/Webqq/Plugin/Wooyun.pm \
	lib/Mojo/Webqq/Plugin/ZhiBo8.pm \
	lib/Mojo/Webqq/Plugin/sleep.txt \
	lib/Mojo/Webqq/Recent/Discuss.pm \
	lib/Mojo/Webqq/Recent/Friend.pm \
	lib/Mojo/Webqq/Recent/Group.pm \
	lib/Mojo/Webqq/Request.pm \
	lib/Mojo/Webqq/Run.pm \
	lib/Mojo/Webqq/Server.pm \
	lib/Mojo/Webqq/User.pm \
	lib/Mojo/Webqq/Util.pm

PM_TO_BLIB = lib/Mojo/Webqq.pm \
	blib\lib\Mojo\Webqq.pm \
	lib/Mojo/Webqq.pod \
	blib\lib\Mojo\Webqq.pod \
	lib/Mojo/Webqq/Base.pm \
	blib\lib\Mojo\Webqq\Base.pm \
	lib/Mojo/Webqq/Cache.pm \
	blib\lib\Mojo\Webqq\Cache.pm \
	lib/Mojo/Webqq/Client.pm \
	blib\lib\Mojo\Webqq\Client.pm \
	lib/Mojo/Webqq/Client/Cron.pm \
	blib\lib\Mojo\Webqq\Client\Cron.pm \
	lib/Mojo/Webqq/Client/Remote/_check_sig.pm \
	blib\lib\Mojo\Webqq\Client\Remote\_check_sig.pm \
	lib/Mojo/Webqq/Client/Remote/_check_verify_code.pm \
	blib\lib\Mojo\Webqq\Client\Remote\_check_verify_code.pm \
	lib/Mojo/Webqq/Client/Remote/_cookie_proxy.pm \
	blib\lib\Mojo\Webqq\Client\Remote\_cookie_proxy.pm \
	lib/Mojo/Webqq/Client/Remote/_get_group_pic.pm \
	blib\lib\Mojo\Webqq\Client\Remote\_get_group_pic.pm \
	lib/Mojo/Webqq/Client/Remote/_get_img_verify_code.pm \
	blib\lib\Mojo\Webqq\Client\Remote\_get_img_verify_code.pm \
	lib/Mojo/Webqq/Client/Remote/_get_offpic.pm \
	blib\lib\Mojo\Webqq\Client\Remote\_get_offpic.pm \
	lib/Mojo/Webqq/Client/Remote/_get_qrlogin_pic.pm \
	blib\lib\Mojo\Webqq\Client\Remote\_get_qrlogin_pic.pm \
	lib/Mojo/Webqq/Client/Remote/_get_vfwebqq.pm \
	blib\lib\Mojo\Webqq\Client\Remote\_get_vfwebqq.pm \
	lib/Mojo/Webqq/Client/Remote/_login1.pm \
	blib\lib\Mojo\Webqq\Client\Remote\_login1.pm \
	lib/Mojo/Webqq/Client/Remote/_login2.pm \
	blib\lib\Mojo\Webqq\Client\Remote\_login2.pm \
	lib/Mojo/Webqq/Client/Remote/_prepare_for_login.pm \
	blib\lib\Mojo\Webqq\Client\Remote\_prepare_for_login.pm \
	lib/Mojo/Webqq/Client/Remote/_recv_message.pm \
	blib\lib\Mojo\Webqq\Client\Remote\_recv_message.pm \
	lib/Mojo/Webqq/Client/Remote/_relink.pm \
	blib\lib\Mojo\Webqq\Client\Remote\_relink.pm \
	lib/Mojo/Webqq/Client/Remote/change_state.pm \
	blib\lib\Mojo\Webqq\Client\Remote\change_state.pm \
	lib/Mojo/Webqq/Client/Remote/logout.pm \
	blib\lib\Mojo\Webqq\Client\Remote\logout.pm \
	lib/Mojo/Webqq/Discuss.pm \
	blib\lib\Mojo\Webqq\Discuss.pm \
	lib/Mojo/Webqq/Discuss/Member.pm \
	blib\lib\Mojo\Webqq\Discuss\Member.pm \
	lib/Mojo/Webqq/Friend.pm \
	blib\lib\Mojo\Webqq\Friend.pm \
	lib/Mojo/Webqq/Group.pm \
	blib\lib\Mojo\Webqq\Group.pm \
	lib/Mojo/Webqq/Group/Member.pm \
	blib\lib\Mojo\Webqq\Group\Member.pm \
	lib/Mojo/Webqq/Log.pm \
	blib\lib\Mojo\Webqq\Log.pm \
	lib/Mojo/Webqq/Message.pm \
	blib\lib\Mojo\Webqq\Message.pm \
	lib/Mojo/Webqq/Message/Base.pm \
	blib\lib\Mojo\Webqq\Message\Base.pm \
	lib/Mojo/Webqq/Message/Emoji.pm \
	blib\lib\Mojo\Webqq\Message\Emoji.pm \
	lib/Mojo/Webqq/Message/Face.pm \
	blib\lib\Mojo\Webqq\Message\Face.pm \
	lib/Mojo/Webqq/Message/Queue.pm \
	blib\lib\Mojo\Webqq\Message\Queue.pm \
	lib/Mojo/Webqq/Message/Recv/DiscussMessage.pm \
	blib\lib\Mojo\Webqq\Message\Recv\DiscussMessage.pm \
	lib/Mojo/Webqq/Message/Recv/GroupMessage.pm \
	blib\lib\Mojo\Webqq\Message\Recv\GroupMessage.pm \
	lib/Mojo/Webqq/Message/Recv/Message.pm \
	blib\lib\Mojo\Webqq\Message\Recv\Message.pm \
	lib/Mojo/Webqq/Message/Recv/SessMessage.pm \
	blib\lib\Mojo\Webqq\Message\Recv\SessMessage.pm \
	lib/Mojo/Webqq/Message/Recv/StateMessage.pm \
	blib\lib\Mojo\Webqq\Message\Recv\StateMessage.pm \
	lib/Mojo/Webqq/Message/Remote/_get_sess_sig.pm \
	blib\lib\Mojo\Webqq\Message\Remote\_get_sess_sig.pm \
	lib/Mojo/Webqq/Message/Remote/_send_discuss_message.pm \
	blib\lib\Mojo\Webqq\Message\Remote\_send_discuss_message.pm \
	lib/Mojo/Webqq/Message/Remote/_send_group_message.pm \
	blib\lib\Mojo\Webqq\Message\Remote\_send_group_message.pm \
	lib/Mojo/Webqq/Message/Remote/_send_message.pm \
	blib\lib\Mojo\Webqq\Message\Remote\_send_message.pm \
	lib/Mojo/Webqq/Message/Remote/_send_sess_message.pm \
	blib\lib\Mojo\Webqq\Message\Remote\_send_sess_message.pm \
	lib/Mojo/Webqq/Message/Send/DiscussMessage.pm \
	blib\lib\Mojo\Webqq\Message\Send\DiscussMessage.pm \
	lib/Mojo/Webqq/Message/Send/GroupMessage.pm \
	blib\lib\Mojo\Webqq\Message\Send\GroupMessage.pm \
	lib/Mojo/Webqq/Message/Send/Message.pm \
	blib\lib\Mojo\Webqq\Message\Send\Message.pm \
	lib/Mojo/Webqq/Message/Send/SessMessage.pm \
	blib\lib\Mojo\Webqq\Message\Send\SessMessage.pm \
	lib/Mojo/Webqq/Message/Send/Status.pm \
	blib\lib\Mojo\Webqq\Message\Send\Status.pm \
	lib/Mojo/Webqq/Message/XMLescape.pm \
	blib\lib\Mojo\Webqq\Message\XMLescape.pm \
	lib/Mojo/Webqq/Model.pm \
	blib\lib\Mojo\Webqq\Model.pm \
	lib/Mojo/Webqq/Model/Base.pm \
	blib\lib\Mojo\Webqq\Model\Base.pm \
	lib/Mojo/Webqq/Model/Remote/_get_discuss_info.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_get_discuss_info.pm \
	lib/Mojo/Webqq/Model/Remote/_get_discuss_list_info.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_get_discuss_list_info.pm \
	lib/Mojo/Webqq/Model/Remote/_get_friend_info.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_get_friend_info.pm \
	lib/Mojo/Webqq/Model/Remote/_get_friends_state.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_get_friends_state.pm \
	lib/Mojo/Webqq/Model/Remote/_get_group_info.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_get_group_info.pm \
	lib/Mojo/Webqq/Model/Remote/_get_group_info_ext.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_get_group_info_ext.pm \
	lib/Mojo/Webqq/Model/Remote/_get_group_list_info.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_get_group_list_info.pm \
	lib/Mojo/Webqq/Model/Remote/_get_group_list_info_ext.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_get_group_list_info_ext.pm \
	lib/Mojo/Webqq/Model/Remote/_get_recent_info.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_get_recent_info.pm \
	lib/Mojo/Webqq/Model/Remote/_get_user_friends.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_get_user_friends.pm \
	lib/Mojo/Webqq/Model/Remote/_get_user_friends_ext.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_get_user_friends_ext.pm \
	lib/Mojo/Webqq/Model/Remote/_get_user_info.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_get_user_info.pm \
	lib/Mojo/Webqq/Model/Remote/_invite_friend.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_invite_friend.pm \
	lib/Mojo/Webqq/Model/Remote/_kick_group_member.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_kick_group_member.pm \
	lib/Mojo/Webqq/Model/Remote/_remove_group_admin.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_remove_group_admin.pm \
	lib/Mojo/Webqq/Model/Remote/_set_group_admin.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_set_group_admin.pm \
	lib/Mojo/Webqq/Model/Remote/_set_group_member_card.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_set_group_member_card.pm \
	lib/Mojo/Webqq/Model/Remote/_shutup_group_member.pm \
	blib\lib\Mojo\Webqq\Model\Remote\_shutup_group_member.pm \
	lib/Mojo/Webqq/Model/Remote/get_qq_from_id.pm \
	blib\lib\Mojo\Webqq\Model\Remote\get_qq_from_id.pm \
	lib/Mojo/Webqq/Model/Remote/get_single_long_nick.pm \
	blib\lib\Mojo\Webqq\Model\Remote\get_single_long_nick.pm \
	lib/Mojo/Webqq/Plugin.pm \
	blib\lib\Mojo\Webqq\Plugin.pm \
	lib/Mojo/Webqq/Plugin/BadLanguage.pm \
	blib\lib\Mojo\Webqq\Plugin\BadLanguage.pm \
	lib/Mojo/Webqq/Plugin/Bayes.pm \
	blib\lib\Mojo\Webqq\Plugin\Bayes.pm \
	lib/Mojo/Webqq/Plugin/Cartoon.pm \
	blib\lib\Mojo\Webqq\Plugin\Cartoon.pm \
	lib/Mojo/Webqq/Plugin/Curl.pm \
	blib\lib\Mojo\Webqq\Plugin\Curl.pm \
	lib/Mojo/Webqq/Plugin/Domain.pm \
	blib\lib\Mojo\Webqq\Plugin\Domain.pm \
	lib/Mojo/Webqq/Plugin/ExchangeRate.pm \
	blib\lib\Mojo\Webqq\Plugin\ExchangeRate.pm \
	lib/Mojo/Webqq/Plugin/Express.pm \
	blib\lib\Mojo\Webqq\Plugin\Express.pm \
	lib/Mojo/Webqq/Plugin/FuckDaShen.pm \
	blib\lib\Mojo\Webqq\Plugin\FuckDaShen.pm \
	lib/Mojo/Webqq/Plugin/GroupManage.pm \
	blib\lib\Mojo\Webqq\Plugin\GroupManage.pm \
	lib/Mojo/Webqq/Plugin/IRCShell.pm \
	blib\lib\Mojo\Webqq\Plugin\IRCShell.pm \
	lib/Mojo/Webqq/Plugin/JavaCode.pm \
	blib\lib\Mojo\Webqq\Plugin\JavaCode.pm \
	lib/Mojo/Webqq/Plugin/KnowledgeBase.pm \
	blib\lib\Mojo\Webqq\Plugin\KnowledgeBase.pm \
	lib/Mojo/Webqq/Plugin/Lottery.pm \
	blib\lib\Mojo\Webqq\Plugin\Lottery.pm \
	lib/Mojo/Webqq/Plugin/MobileInfo.pm \
	blib\lib\Mojo\Webqq\Plugin\MobileInfo.pm \
	lib/Mojo/Webqq/Plugin/Monitor.pm \
	blib\lib\Mojo\Webqq\Plugin\Monitor.pm \
	lib/Mojo/Webqq/Plugin/MsgSync.pm \
	blib\lib\Mojo\Webqq\Plugin\MsgSync.pm \
	lib/Mojo/Webqq/Plugin/Openqq.pm \
	blib\lib\Mojo\Webqq\Plugin\Openqq.pm \
	lib/Mojo/Webqq/Plugin/Perlcode.pm \
	blib\lib\Mojo\Webqq\Plugin\Perlcode.pm \
	lib/Mojo/Webqq/Plugin/Perldoc.pm \
	blib\lib\Mojo\Webqq\Plugin\Perldoc.pm \
	lib/Mojo/Webqq/Plugin/Poetry.pm \
	blib\lib\Mojo\Webqq\Plugin\Poetry.pm \
	lib/Mojo/Webqq/Plugin/PostImgVerifycode.pm \
	blib\lib\Mojo\Webqq\Plugin\PostImgVerifycode.pm \
	lib/Mojo/Webqq/Plugin/PostQRcode.pm \
	blib\lib\Mojo\Webqq\Plugin\PostQRcode.pm \
	lib/Mojo/Webqq/Plugin/ProgramCode.pm \
	blib\lib\Mojo\Webqq\Plugin\ProgramCode.pm \
	lib/Mojo/Webqq/Plugin/PushPlug.pm \
	blib\lib\Mojo\Webqq\Plugin\PushPlug.pm \
	lib/Mojo/Webqq/Plugin/QQMsgSync.pm \
	blib\lib\Mojo\Webqq\Plugin\QQMsgSync.pm \
	lib/Mojo/Webqq/Plugin/Questions.pm \
	blib\lib\Mojo\Webqq\Plugin\Questions.pm \
	lib/Mojo/Webqq/Plugin/RedisDoc.pm \
	blib\lib\Mojo\Webqq\Plugin\RedisDoc.pm \
	lib/Mojo/Webqq/Plugin/SearchEngine.pm \
	blib\lib\Mojo\Webqq\Plugin\SearchEngine.pm \
	lib/Mojo/Webqq/Plugin/ShowMsg.pm \
	blib\lib\Mojo\Webqq\Plugin\ShowMsg.pm \
	lib/Mojo/Webqq/Plugin/SleepRecord.pm \
	blib\lib\Mojo\Webqq\Plugin\SleepRecord.pm \
	lib/Mojo/Webqq/Plugin/SmartReply.pm \
	blib\lib\Mojo\Webqq\Plugin\SmartReply.pm \
	lib/Mojo/Webqq/Plugin/SongKTV.pm \
	blib\lib\Mojo\Webqq\Plugin\SongKTV.pm \
	lib/Mojo/Webqq/Plugin/SongWord.pm \
	blib\lib\Mojo\Webqq\Plugin\SongWord.pm \
	lib/Mojo/Webqq/Plugin/SparkShell.pm \
	blib\lib\Mojo\Webqq\Plugin\SparkShell.pm \
	lib/Mojo/Webqq/Plugin/StockInfo.pm \
	blib\lib\Mojo\Webqq\Plugin\StockInfo.pm \
	lib/Mojo/Webqq/Plugin/Translation.pm \
	blib\lib\Mojo\Webqq\Plugin\Translation.pm \
	lib/Mojo/Webqq/Plugin/Wisdom.pm \
	blib\lib\Mojo\Webqq\Plugin\Wisdom.pm \
	lib/Mojo/Webqq/Plugin/Wooyun.pm \
	blib\lib\Mojo\Webqq\Plugin\Wooyun.pm \
	lib/Mojo/Webqq/Plugin/ZhiBo8.pm \
	blib\lib\Mojo\Webqq\Plugin\ZhiBo8.pm \
	lib/Mojo/Webqq/Plugin/sleep.txt \
	blib\lib\Mojo\Webqq\Plugin\sleep.txt \
	lib/Mojo/Webqq/Recent/Discuss.pm \
	blib\lib\Mojo\Webqq\Recent\Discuss.pm \
	lib/Mojo/Webqq/Recent/Friend.pm \
	blib\lib\Mojo\Webqq\Recent\Friend.pm \
	lib/Mojo/Webqq/Recent/Group.pm \
	blib\lib\Mojo\Webqq\Recent\Group.pm \
	lib/Mojo/Webqq/Request.pm \
	blib\lib\Mojo\Webqq\Request.pm \
	lib/Mojo/Webqq/Run.pm \
	blib\lib\Mojo\Webqq\Run.pm \
	lib/Mojo/Webqq/Server.pm \
	blib\lib\Mojo\Webqq\Server.pm \
	lib/Mojo/Webqq/User.pm \
	blib\lib\Mojo\Webqq\User.pm \
	lib/Mojo/Webqq/Util.pm \
	blib\lib\Mojo\Webqq\Util.pm


# --- MakeMaker platform_constants section:
MM_Win32_VERSION = 7.04


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(ABSPERLRUN)  -e "use AutoSplit;  autosplit($$$$ARGV[0], $$$$ARGV[1], 0, 1, 1)" --



# --- MakeMaker tool_xsubpp section:


# --- MakeMaker tools_other section:
CHMOD = $(ABSPERLRUN) -MExtUtils::Command -e chmod --
CP = $(ABSPERLRUN) -MExtUtils::Command -e cp --
MV = $(ABSPERLRUN) -MExtUtils::Command -e mv --
NOOP = rem
NOECHO = @
RM_F = $(ABSPERLRUN) -MExtUtils::Command -e rm_f --
RM_RF = $(ABSPERLRUN) -MExtUtils::Command -e rm_rf --
TEST_F = $(ABSPERLRUN) -MExtUtils::Command -e test_f --
TOUCH = $(ABSPERLRUN) -MExtUtils::Command -e touch --
UMASK_NULL = umask 0
DEV_NULL = > NUL
MKPATH = $(ABSPERLRUN) -MExtUtils::Command -e mkpath --
EQUALIZE_TIMESTAMP = $(ABSPERLRUN) -MExtUtils::Command -e eqtime --
FALSE = $(ABSPERLRUN)  -e "exit 1" --
TRUE = $(ABSPERLRUN)  -e "exit 0" --
ECHO = $(ABSPERLRUN) -l -e "binmode STDOUT, qq{{:raw}}; print qq{{@ARGV}}" --
ECHO_N = $(ABSPERLRUN)  -e "print qq{{@ARGV}}" --
UNINST = 0
VERBINST = 0
MOD_INSTALL = $(ABSPERLRUN) -MExtUtils::Install -e "install([ from_to => {{@ARGV}}, verbose => '$(VERBINST)', uninstall_shadows => '$(UNINST)', dir_mode => '$(PERM_DIR)' ]);" --
DOC_INSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e perllocal_install --
UNINSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e uninstall --
WARN_IF_OLD_PACKLIST = $(ABSPERLRUN) -MExtUtils::Command::MM -e warn_if_old_packlist --
MACROSTART = 
MACROEND = 
USEMAKEFILE = -f
FIXIN = pl2bat.bat
CP_NONEMPTY = $(ABSPERLRUN) -MExtUtils::Command::MM -e cp_nonempty --


# --- MakeMaker makemakerdflt section:
makemakerdflt : all
	$(NOECHO) $(NOOP)


# --- MakeMaker dist section:
TAR = tar
TARFLAGS = cvf
ZIP = zip
ZIPFLAGS = -r
COMPRESS = gzip -9f
SUFFIX = .gz
SHAR = shar
PREOP = $(NOECHO) $(NOOP)
POSTOP = $(NOECHO) $(NOOP)
TO_UNIX = $(NOECHO) $(NOOP)
CI = ci -u
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q
DIST_CP = best
DIST_DEFAULT = tardist
DISTNAME = Mojo-Webqq
DISTVNAME = Mojo-Webqq-1.6.7


# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:


# --- MakeMaker const_loadlibs section:


# --- MakeMaker const_cccmd section:


# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:
PASTHRU = 

# --- MakeMaker special_targets section:
.SUFFIXES : .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

.PHONY: all config static dynamic test linkext manifest blibdirs clean realclean disttest distdir

.USESHELL :


# --- MakeMaker c_o section:


# --- MakeMaker xs_c section:


# --- MakeMaker xs_o section:


# --- MakeMaker top_targets section:
all :: pure_all
	$(NOECHO) $(NOOP)


pure_all :: config pm_to_blib subdirs linkext
	$(NOECHO) $(NOOP)

subdirs :: $(MYEXTLIB)
	$(NOECHO) $(NOOP)

config :: $(FIRST_MAKEFILE) blibdirs
	$(NOECHO) $(NOOP)

help :
	perldoc ExtUtils::MakeMaker


# --- MakeMaker blibdirs section:
blibdirs : $(INST_LIBDIR)$(DFSEP).exists $(INST_ARCHLIB)$(DFSEP).exists $(INST_AUTODIR)$(DFSEP).exists $(INST_ARCHAUTODIR)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists $(INST_SCRIPT)$(DFSEP).exists $(INST_MAN1DIR)$(DFSEP).exists $(INST_MAN3DIR)$(DFSEP).exists
	$(NOECHO) $(NOOP)

# Backwards compat with 6.18 through 6.25
blibdirs.ts : blibdirs
	$(NOECHO) $(NOOP)

$(INST_LIBDIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_LIBDIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_LIBDIR)
	$(NOECHO) $(TOUCH) $(INST_LIBDIR)$(DFSEP).exists

$(INST_ARCHLIB)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHLIB)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHLIB)
	$(NOECHO) $(TOUCH) $(INST_ARCHLIB)$(DFSEP).exists

$(INST_AUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_AUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_AUTODIR)
	$(NOECHO) $(TOUCH) $(INST_AUTODIR)$(DFSEP).exists

$(INST_ARCHAUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHAUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHAUTODIR)
	$(NOECHO) $(TOUCH) $(INST_ARCHAUTODIR)$(DFSEP).exists

$(INST_BIN)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_BIN)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_BIN)
	$(NOECHO) $(TOUCH) $(INST_BIN)$(DFSEP).exists

$(INST_SCRIPT)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_SCRIPT)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_SCRIPT)
	$(NOECHO) $(TOUCH) $(INST_SCRIPT)$(DFSEP).exists

$(INST_MAN1DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN1DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN1DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN1DIR)$(DFSEP).exists

$(INST_MAN3DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN3DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN3DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN3DIR)$(DFSEP).exists



# --- MakeMaker linkext section:

linkext :: $(LINKTYPE)
	$(NOECHO) $(NOOP)


# --- MakeMaker dlsyms section:

Webqq.def: Makefile.PL
	$(PERLRUN) -MExtUtils::Mksymlists \
     -e "Mksymlists('NAME'=>\"Mojo::Webqq\", 'DLBASE' => '$(BASEEXT)', 'DL_FUNCS' => {  }, 'FUNCLIST' => [], 'IMPORTS' => {  }, 'DL_VARS' => []);"


# --- MakeMaker dynamic_bs section:

BOOTSTRAP =


# --- MakeMaker dynamic section:

dynamic :: $(FIRST_MAKEFILE) $(BOOTSTRAP) $(INST_DYNAMIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker dynamic_lib section:


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
static :: $(FIRST_MAKEFILE) $(INST_STATIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker static_lib section:


# --- MakeMaker manifypods section:

POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--"
POD2MAN = $(POD2MAN_EXE)


manifypods : pure_all 
	$(NOECHO) $(NOOP)




# --- MakeMaker processPL section:


# --- MakeMaker installbin section:


# --- MakeMaker subdirs section:

# none

# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean :: clean_subdirs
	- $(RM_F) \
	  $(BASEEXT).bso $(BASEEXT).def \
	  $(BASEEXT).exp $(BASEEXT).x \
	  $(BOOTSTRAP) $(INST_ARCHAUTODIR)\extralibs.all \
	  $(INST_ARCHAUTODIR)\extralibs.ld $(MAKE_APERL_FILE) \
	  *$(LIB_EXT) *$(OBJ_EXT) \
	  *perl.core MYMETA.json \
	  MYMETA.yml blibdirs.ts \
	  core core.*perl.*.? \
	  core.[0-9] core.[0-9][0-9] \
	  core.[0-9][0-9][0-9] core.[0-9][0-9][0-9][0-9] \
	  core.[0-9][0-9][0-9][0-9][0-9] lib$(BASEEXT).def \
	  mon.out perl \
	  perl$(EXE_EXT) perl.exe \
	  perlmain.c pm_to_blib \
	  pm_to_blib.ts so_locations \
	  tmon.out 
	- $(RM_RF) \
	  MANIFEST Mojo-Webqq-* \
	  blib dll.base \
	  dll.exp 
	  $(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	- $(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
realclean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker realclean section:
# Delete temporary files (via clean) and also delete dist files
realclean purge ::  clean realclean_subdirs
	- $(RM_F) \
	  $(MAKEFILE_OLD) $(FIRST_MAKEFILE) 
	- $(RM_RF) \
	  $(DISTVNAME) 


# --- MakeMaker metafile section:
metafile : create_distdir
	$(NOECHO) $(ECHO) Generating META.yml
	$(NOECHO) $(ECHO) --- > META_new.yml
	$(NOECHO) $(ECHO) "abstract: 'A Smartqq Client Framework base on Mojolicious'" >> META_new.yml
	$(NOECHO) $(ECHO) author: >> META_new.yml
	$(NOECHO) $(ECHO) "  - 'sjdy521 <sjdy521@163.com>'" >> META_new.yml
	$(NOECHO) $(ECHO) build_requires: >> META_new.yml
	$(NOECHO) $(ECHO) "  ExtUtils::MakeMaker: '0'" >> META_new.yml
	$(NOECHO) $(ECHO) configure_requires: >> META_new.yml
	$(NOECHO) $(ECHO) "  ExtUtils::MakeMaker: '0'" >> META_new.yml
	$(NOECHO) $(ECHO) "dynamic_config: 1" >> META_new.yml
	$(NOECHO) $(ECHO) "generated_by: 'ExtUtils::MakeMaker version 7.04, CPAN::Meta::Converter version 2.143240'" >> META_new.yml
	$(NOECHO) $(ECHO) "license: perl" >> META_new.yml
	$(NOECHO) $(ECHO) meta-spec: >> META_new.yml
	$(NOECHO) $(ECHO) "  url: http://module-build.sourceforge.net/META-spec-v1.4.html" >> META_new.yml
	$(NOECHO) $(ECHO) "  version: '1.4'" >> META_new.yml
	$(NOECHO) $(ECHO) "name: Mojo-Webqq" >> META_new.yml
	$(NOECHO) $(ECHO) no_index: >> META_new.yml
	$(NOECHO) $(ECHO) "  directory:" >> META_new.yml
	$(NOECHO) $(ECHO) "    - t" >> META_new.yml
	$(NOECHO) $(ECHO) "    - inc" >> META_new.yml
	$(NOECHO) $(ECHO) requires: >> META_new.yml
	$(NOECHO) $(ECHO) "  Encode::Locale: '0'" >> META_new.yml
	$(NOECHO) $(ECHO) "  IO::Socket::SSL: '1.94'" >> META_new.yml
	$(NOECHO) $(ECHO) "  Mojolicious: '6.11'" >> META_new.yml
	$(NOECHO) $(ECHO) "  Time::HiRes: '0'" >> META_new.yml
	$(NOECHO) $(ECHO) "  Time::Piece: '0'" >> META_new.yml
	$(NOECHO) $(ECHO) "  Time::Seconds: '0'" >> META_new.yml
	$(NOECHO) $(ECHO) resources: >> META_new.yml
	$(NOECHO) $(ECHO) "  repository: git://github.com/sjdy521/Mojo-Webqq.git" >> META_new.yml
	$(NOECHO) $(ECHO) "version: v1.6.7" >> META_new.yml
	-$(NOECHO) $(MV) META_new.yml $(DISTVNAME)/META.yml
	$(NOECHO) $(ECHO) Generating META.json
	$(NOECHO) $(ECHO) {{ > META_new.json
	$(NOECHO) $(ECHO) "   \"abstract\" : \"A Smartqq Client Framework base on Mojolicious\"," >> META_new.json
	$(NOECHO) $(ECHO) "   \"author\" : [" >> META_new.json
	$(NOECHO) $(ECHO) "      \"sjdy521 ^<sjdy521^@163.com^>\"" >> META_new.json
	$(NOECHO) $(ECHO) "   ]," >> META_new.json
	$(NOECHO) $(ECHO) "   \"dynamic_config\" : 1," >> META_new.json
	$(NOECHO) $(ECHO) "   \"generated_by\" : \"ExtUtils::MakeMaker version 7.04, CPAN::Meta::Converter version 2.143240\"," >> META_new.json
	$(NOECHO) $(ECHO) "   \"license\" : [" >> META_new.json
	$(NOECHO) $(ECHO) "      \"perl_5\"" >> META_new.json
	$(NOECHO) $(ECHO) "   ]," >> META_new.json
	$(NOECHO) $(ECHO) "   \"meta-spec\" : {{" >> META_new.json
	$(NOECHO) $(ECHO) "      \"url\" : \"http://search.cpan.org/perldoc?CPAN::Meta::Spec\"," >> META_new.json
	$(NOECHO) $(ECHO) "      \"version\" : \"2\"" >> META_new.json
	$(NOECHO) $(ECHO) "   }}," >> META_new.json
	$(NOECHO) $(ECHO) "   \"name\" : \"Mojo-Webqq\"," >> META_new.json
	$(NOECHO) $(ECHO) "   \"no_index\" : {{" >> META_new.json
	$(NOECHO) $(ECHO) "      \"directory\" : [" >> META_new.json
	$(NOECHO) $(ECHO) "         \"t\"," >> META_new.json
	$(NOECHO) $(ECHO) "         \"inc\"" >> META_new.json
	$(NOECHO) $(ECHO) "      ]" >> META_new.json
	$(NOECHO) $(ECHO) "   }}," >> META_new.json
	$(NOECHO) $(ECHO) "   \"prereqs\" : {{" >> META_new.json
	$(NOECHO) $(ECHO) "      \"build\" : {{" >> META_new.json
	$(NOECHO) $(ECHO) "         \"requires\" : {{" >> META_new.json
	$(NOECHO) $(ECHO) "            \"ExtUtils::MakeMaker\" : \"0\"" >> META_new.json
	$(NOECHO) $(ECHO) "         }}" >> META_new.json
	$(NOECHO) $(ECHO) "      }}," >> META_new.json
	$(NOECHO) $(ECHO) "      \"configure\" : {{" >> META_new.json
	$(NOECHO) $(ECHO) "         \"requires\" : {{" >> META_new.json
	$(NOECHO) $(ECHO) "            \"ExtUtils::MakeMaker\" : \"0\"" >> META_new.json
	$(NOECHO) $(ECHO) "         }}" >> META_new.json
	$(NOECHO) $(ECHO) "      }}," >> META_new.json
	$(NOECHO) $(ECHO) "      \"runtime\" : {{" >> META_new.json
	$(NOECHO) $(ECHO) "         \"requires\" : {{" >> META_new.json
	$(NOECHO) $(ECHO) "            \"Encode::Locale\" : \"0\"," >> META_new.json
	$(NOECHO) $(ECHO) "            \"IO::Socket::SSL\" : \"1.94\"," >> META_new.json
	$(NOECHO) $(ECHO) "            \"Mojolicious\" : \"6.11\"," >> META_new.json
	$(NOECHO) $(ECHO) "            \"Time::HiRes\" : \"0\"," >> META_new.json
	$(NOECHO) $(ECHO) "            \"Time::Piece\" : \"0\"," >> META_new.json
	$(NOECHO) $(ECHO) "            \"Time::Seconds\" : \"0\"" >> META_new.json
	$(NOECHO) $(ECHO) "         }}" >> META_new.json
	$(NOECHO) $(ECHO) "      }}" >> META_new.json
	$(NOECHO) $(ECHO) "   }}," >> META_new.json
	$(NOECHO) $(ECHO) "   \"release_status\" : \"stable\"," >> META_new.json
	$(NOECHO) $(ECHO) "   \"resources\" : {{" >> META_new.json
	$(NOECHO) $(ECHO) "      \"repository\" : {{" >> META_new.json
	$(NOECHO) $(ECHO) "         \"type\" : \"git\"," >> META_new.json
	$(NOECHO) $(ECHO) "         \"url\" : \"git://github.com/sjdy521/Mojo-Webqq.git\"," >> META_new.json
	$(NOECHO) $(ECHO) "         \"web\" : \"https://github.com/sjdy521/Mojo-Webqq\"" >> META_new.json
	$(NOECHO) $(ECHO) "      }}" >> META_new.json
	$(NOECHO) $(ECHO) "   }}," >> META_new.json
	$(NOECHO) $(ECHO) "   \"version\" : \"v1.6.7\"" >> META_new.json
	$(NOECHO) $(ECHO) }} >> META_new.json
	-$(NOECHO) $(MV) META_new.json $(DISTVNAME)/META.json


# --- MakeMaker signature section:
signature :
	cpansign -s


# --- MakeMaker dist_basics section:
distclean :: realclean distcheck
	$(NOECHO) $(NOOP)

distcheck :
	$(PERLRUN) "-MExtUtils::Manifest=fullcheck" -e fullcheck

skipcheck :
	$(PERLRUN) "-MExtUtils::Manifest=skipcheck" -e skipcheck

manifest :
	$(PERLRUN) "-MExtUtils::Manifest=mkmanifest" -e mkmanifest

veryclean : realclean
	$(RM_F) *~ */*~ *.orig */*.orig *.bak */*.bak *.old */*.old



# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT) $(FIRST_MAKEFILE)
	$(NOECHO) $(ABSPERLRUN) -l -e "print 'Warning: Makefile possibly out of date with $(VERSION_FROM)'\
    if -e '$(VERSION_FROM)' and -M '$(VERSION_FROM)' < -M '$(FIRST_MAKEFILE)';" --

tardist : $(DISTVNAME).tar$(SUFFIX)
	$(NOECHO) $(NOOP)

uutardist : $(DISTVNAME).tar$(SUFFIX)
	uuencode $(DISTVNAME).tar$(SUFFIX) $(DISTVNAME).tar$(SUFFIX) > $(DISTVNAME).tar$(SUFFIX)_uu
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).tar$(SUFFIX)_uu'

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).tar$(SUFFIX)'
	$(POSTOP)

zipdist : $(DISTVNAME).zip
	$(NOECHO) $(NOOP)

$(DISTVNAME).zip : distdir
	$(PREOP)
	$(ZIP) $(ZIPFLAGS) $(DISTVNAME).zip $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).zip'
	$(POSTOP)

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).shar'
	$(POSTOP)


# --- MakeMaker distdir section:
create_distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \
		-e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"

distdir : create_distdir distmeta 
	$(NOECHO) $(NOOP)



# --- MakeMaker dist_test section:
disttest : distdir
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL 
	cd $(DISTVNAME) && $(MAKE) $(PASTHRU)
	cd $(DISTVNAME) && $(MAKE) test $(PASTHRU)



# --- MakeMaker dist_ci section:

ci :
	$(PERLRUN) "-MExtUtils::Manifest=maniread" \
	  -e "@all = keys %{ maniread() };" \
	  -e "print(qq{Executing $(CI) @all\n}); system(qq{$(CI) @all});" \
	  -e "print(qq{Executing $(RCS_LABEL) ...\n}); system(qq{$(RCS_LABEL) @all});"


# --- MakeMaker distmeta section:
distmeta : create_distdir metafile
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e "exit unless -e q{{META.yml}};\
eval {{ maniadd({{q{{META.yml}} => q{{Module YAML meta-data (added by MakeMaker)}}}}) }}\
    or print \"Could not add META.yml to MANIFEST: $$$${{'^@'}}\n\"" --
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e "exit unless -f q{{META.json}};\
eval {{ maniadd({{q{{META.json}} => q{{Module JSON meta-data (added by MakeMaker)}}}}) }}\
    or print \"Could not add META.json to MANIFEST: $$$${{'^@'}}\n\"" --



# --- MakeMaker distsignature section:
distsignature : create_distdir
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e "eval {{ maniadd({{q{{SIGNATURE}} => q{{Public-key signature (added by MakeMaker)}}}}) }}\
    or print \"Could not add SIGNATURE to MANIFEST: $$$${{'^@'}}\n\"" --
	$(NOECHO) cd $(DISTVNAME) && $(TOUCH) SIGNATURE
	cd $(DISTVNAME) && cpansign -s



# --- MakeMaker install section:

install :: pure_install doc_install
	$(NOECHO) $(NOOP)

install_perl :: pure_perl_install doc_perl_install
	$(NOECHO) $(NOOP)

install_site :: pure_site_install doc_site_install
	$(NOECHO) $(NOOP)

install_vendor :: pure_vendor_install doc_vendor_install
	$(NOECHO) $(NOOP)

pure_install :: pure_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

doc_install :: doc_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

pure__install : pure_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install :: all
	$(NOECHO) $(MOD_INSTALL) \
		read "$(PERL_ARCHLIB)\auto\$(FULLEXT)\.packlist" \
		write "$(DESTINSTALLARCHLIB)\auto\$(FULLEXT)\.packlist" \
		"$(INST_LIB)" "$(DESTINSTALLPRIVLIB)" \
		"$(INST_ARCHLIB)" "$(DESTINSTALLARCHLIB)" \
		"$(INST_BIN)" "$(DESTINSTALLBIN)" \
		"$(INST_SCRIPT)" "$(DESTINSTALLSCRIPT)" \
		"$(INST_MAN1DIR)" "$(DESTINSTALLMAN1DIR)" \
		"$(INST_MAN3DIR)" "$(DESTINSTALLMAN3DIR)"
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		"$(SITEARCHEXP)\auto\$(FULLEXT)"


pure_site_install :: all
	$(NOECHO) $(MOD_INSTALL) \
		read "$(SITEARCHEXP)\auto\$(FULLEXT)\.packlist" \
		write "$(DESTINSTALLSITEARCH)\auto\$(FULLEXT)\.packlist" \
		"$(INST_LIB)" "$(DESTINSTALLSITELIB)" \
		"$(INST_ARCHLIB)" "$(DESTINSTALLSITEARCH)" \
		"$(INST_BIN)" "$(DESTINSTALLSITEBIN)" \
		"$(INST_SCRIPT)" "$(DESTINSTALLSITESCRIPT)" \
		"$(INST_MAN1DIR)" "$(DESTINSTALLSITEMAN1DIR)" \
		"$(INST_MAN3DIR)" "$(DESTINSTALLSITEMAN3DIR)"
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		"$(PERL_ARCHLIB)\auto\$(FULLEXT)"

pure_vendor_install :: all
	$(NOECHO) $(MOD_INSTALL) \
		read "$(VENDORARCHEXP)\auto\$(FULLEXT)\.packlist" \
		write "$(DESTINSTALLVENDORARCH)\auto\$(FULLEXT)\.packlist" \
		"$(INST_LIB)" "$(DESTINSTALLVENDORLIB)" \
		"$(INST_ARCHLIB)" "$(DESTINSTALLVENDORARCH)" \
		"$(INST_BIN)" "$(DESTINSTALLVENDORBIN)" \
		"$(INST_SCRIPT)" "$(DESTINSTALLVENDORSCRIPT)" \
		"$(INST_MAN1DIR)" "$(DESTINSTALLVENDORMAN1DIR)" \
		"$(INST_MAN3DIR)" "$(DESTINSTALLVENDORMAN3DIR)"


doc_perl_install :: all
	$(NOECHO) $(ECHO) Appending installation info to "$(DESTINSTALLARCHLIB)/perllocal.pod"
	-$(NOECHO) $(MKPATH) "$(DESTINSTALLARCHLIB)"
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" $(INSTALLPRIVLIB) \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> "$(DESTINSTALLARCHLIB)\perllocal.pod"

doc_site_install :: all
	$(NOECHO) $(ECHO) Appending installation info to "$(DESTINSTALLARCHLIB)/perllocal.pod"
	-$(NOECHO) $(MKPATH) "$(DESTINSTALLARCHLIB)"
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" $(INSTALLSITELIB) \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> "$(DESTINSTALLARCHLIB)\perllocal.pod"

doc_vendor_install :: all
	$(NOECHO) $(ECHO) Appending installation info to "$(DESTINSTALLARCHLIB)/perllocal.pod"
	-$(NOECHO) $(MKPATH) "$(DESTINSTALLARCHLIB)"
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" $(INSTALLVENDORLIB) \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> "$(DESTINSTALLARCHLIB)\perllocal.pod"


uninstall :: uninstall_from_$(INSTALLDIRS)dirs
	$(NOECHO) $(NOOP)

uninstall_from_perldirs ::
	$(NOECHO) $(UNINSTALL) "$(PERL_ARCHLIB)\auto\$(FULLEXT)\.packlist"

uninstall_from_sitedirs ::
	$(NOECHO) $(UNINSTALL) "$(SITEARCHEXP)\auto\$(FULLEXT)\.packlist"

uninstall_from_vendordirs ::
	$(NOECHO) $(UNINSTALL) "$(VENDORARCHEXP)\auto\$(FULLEXT)\.packlist"


# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE :
	$(NOECHO) $(NOOP)


# --- MakeMaker perldepend section:


# --- MakeMaker makefile section:
# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
$(FIRST_MAKEFILE) : Makefile.PL $(CONFIGDEP)
	$(NOECHO) $(ECHO) "Makefile out-of-date with respect to $?"
	$(NOECHO) $(ECHO) "Cleaning current config before rebuilding Makefile..."
	-$(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	-$(NOECHO) $(MV)   $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
	- $(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) clean $(DEV_NULL)
	$(PERLRUN) Makefile.PL 
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the $(MAKE) command.  <=="
	$(FALSE)



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = "D:\myapp\Strawberry\perl\bin\perl.exe"

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) $(USEMAKEFILE) $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE) pm_to_blib
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR="" \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS=


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/*.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE) subdirs-test

subdirs-test ::
	$(NOECHO) $(NOOP)


test_dynamic :: pure_all
	$(FULLPERLRUN) "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_dynamic :: pure_all
	$(FULLPERLRUN) $(TESTDB_SW) "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

test_ : test_dynamic

test_static :: test_dynamic
testdb_static :: testdb_dynamic


# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd :
	$(NOECHO) $(ECHO) "<SOFTPKG NAME=\"$(DISTNAME)\" VERSION=\"$(VERSION)\">" > $(DISTNAME).ppd
	$(NOECHO) $(ECHO) "    <ABSTRACT>A Smartqq Client Framework base on Mojolicious</ABSTRACT>" >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) "    <AUTHOR>sjdy521 &lt;sjdy521@163.com&gt;</AUTHOR>" >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) "    <IMPLEMENTATION>" >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) "        <REQUIRE NAME=\"Encode::Locale\" />" >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) "        <REQUIRE NAME=\"IO::Socket::SSL\" VERSION=\"1.94\" />" >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) "        <REQUIRE NAME=\"Mojolicious::\" VERSION=\"6.11\" />" >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) "        <REQUIRE NAME=\"Time::HiRes\" />" >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) "        <REQUIRE NAME=\"Time::Piece\" />" >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) "        <REQUIRE NAME=\"Time::Seconds\" />" >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) "        <ARCHITECTURE NAME=\"MSWin32-x64-multi-thread-5.20\" />" >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) "        <CODEBASE HREF=\"\" />" >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) "    </IMPLEMENTATION>" >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) ^</SOFTPKG^> >> $(DISTNAME).ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib : $(FIRST_MAKEFILE) $(TO_INST_PM)
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e "pm_to_blib({{@ARGV}}, '$(INST_LIB)\auto', q[$(PM_FILTER)], '$(PERM_DIR)')" -- \
	  lib/Mojo/Webqq.pm blib\lib\Mojo\Webqq.pm \
	  lib/Mojo/Webqq.pod blib\lib\Mojo\Webqq.pod \
	  lib/Mojo/Webqq/Base.pm blib\lib\Mojo\Webqq\Base.pm \
	  lib/Mojo/Webqq/Cache.pm blib\lib\Mojo\Webqq\Cache.pm \
	  lib/Mojo/Webqq/Client.pm blib\lib\Mojo\Webqq\Client.pm \
	  lib/Mojo/Webqq/Client/Cron.pm blib\lib\Mojo\Webqq\Client\Cron.pm \
	  lib/Mojo/Webqq/Client/Remote/_check_sig.pm blib\lib\Mojo\Webqq\Client\Remote\_check_sig.pm \
	  lib/Mojo/Webqq/Client/Remote/_check_verify_code.pm blib\lib\Mojo\Webqq\Client\Remote\_check_verify_code.pm \
	  lib/Mojo/Webqq/Client/Remote/_cookie_proxy.pm blib\lib\Mojo\Webqq\Client\Remote\_cookie_proxy.pm \
	  lib/Mojo/Webqq/Client/Remote/_get_group_pic.pm blib\lib\Mojo\Webqq\Client\Remote\_get_group_pic.pm \
	  lib/Mojo/Webqq/Client/Remote/_get_img_verify_code.pm blib\lib\Mojo\Webqq\Client\Remote\_get_img_verify_code.pm \
	  lib/Mojo/Webqq/Client/Remote/_get_offpic.pm blib\lib\Mojo\Webqq\Client\Remote\_get_offpic.pm \
	  lib/Mojo/Webqq/Client/Remote/_get_qrlogin_pic.pm blib\lib\Mojo\Webqq\Client\Remote\_get_qrlogin_pic.pm \
	  lib/Mojo/Webqq/Client/Remote/_get_vfwebqq.pm blib\lib\Mojo\Webqq\Client\Remote\_get_vfwebqq.pm \
	  lib/Mojo/Webqq/Client/Remote/_login1.pm blib\lib\Mojo\Webqq\Client\Remote\_login1.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e "pm_to_blib({{@ARGV}}, '$(INST_LIB)\auto', q[$(PM_FILTER)], '$(PERM_DIR)')" -- \
	  lib/Mojo/Webqq/Client/Remote/_login2.pm blib\lib\Mojo\Webqq\Client\Remote\_login2.pm \
	  lib/Mojo/Webqq/Client/Remote/_prepare_for_login.pm blib\lib\Mojo\Webqq\Client\Remote\_prepare_for_login.pm \
	  lib/Mojo/Webqq/Client/Remote/_recv_message.pm blib\lib\Mojo\Webqq\Client\Remote\_recv_message.pm \
	  lib/Mojo/Webqq/Client/Remote/_relink.pm blib\lib\Mojo\Webqq\Client\Remote\_relink.pm \
	  lib/Mojo/Webqq/Client/Remote/change_state.pm blib\lib\Mojo\Webqq\Client\Remote\change_state.pm \
	  lib/Mojo/Webqq/Client/Remote/logout.pm blib\lib\Mojo\Webqq\Client\Remote\logout.pm \
	  lib/Mojo/Webqq/Discuss.pm blib\lib\Mojo\Webqq\Discuss.pm \
	  lib/Mojo/Webqq/Discuss/Member.pm blib\lib\Mojo\Webqq\Discuss\Member.pm \
	  lib/Mojo/Webqq/Friend.pm blib\lib\Mojo\Webqq\Friend.pm \
	  lib/Mojo/Webqq/Group.pm blib\lib\Mojo\Webqq\Group.pm \
	  lib/Mojo/Webqq/Group/Member.pm blib\lib\Mojo\Webqq\Group\Member.pm \
	  lib/Mojo/Webqq/Log.pm blib\lib\Mojo\Webqq\Log.pm \
	  lib/Mojo/Webqq/Message.pm blib\lib\Mojo\Webqq\Message.pm \
	  lib/Mojo/Webqq/Message/Base.pm blib\lib\Mojo\Webqq\Message\Base.pm \
	  lib/Mojo/Webqq/Message/Emoji.pm blib\lib\Mojo\Webqq\Message\Emoji.pm \
	  lib/Mojo/Webqq/Message/Face.pm blib\lib\Mojo\Webqq\Message\Face.pm \
	  lib/Mojo/Webqq/Message/Queue.pm blib\lib\Mojo\Webqq\Message\Queue.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e "pm_to_blib({{@ARGV}}, '$(INST_LIB)\auto', q[$(PM_FILTER)], '$(PERM_DIR)')" -- \
	  lib/Mojo/Webqq/Message/Recv/DiscussMessage.pm blib\lib\Mojo\Webqq\Message\Recv\DiscussMessage.pm \
	  lib/Mojo/Webqq/Message/Recv/GroupMessage.pm blib\lib\Mojo\Webqq\Message\Recv\GroupMessage.pm \
	  lib/Mojo/Webqq/Message/Recv/Message.pm blib\lib\Mojo\Webqq\Message\Recv\Message.pm \
	  lib/Mojo/Webqq/Message/Recv/SessMessage.pm blib\lib\Mojo\Webqq\Message\Recv\SessMessage.pm \
	  lib/Mojo/Webqq/Message/Recv/StateMessage.pm blib\lib\Mojo\Webqq\Message\Recv\StateMessage.pm \
	  lib/Mojo/Webqq/Message/Remote/_get_sess_sig.pm blib\lib\Mojo\Webqq\Message\Remote\_get_sess_sig.pm \
	  lib/Mojo/Webqq/Message/Remote/_send_discuss_message.pm blib\lib\Mojo\Webqq\Message\Remote\_send_discuss_message.pm \
	  lib/Mojo/Webqq/Message/Remote/_send_group_message.pm blib\lib\Mojo\Webqq\Message\Remote\_send_group_message.pm \
	  lib/Mojo/Webqq/Message/Remote/_send_message.pm blib\lib\Mojo\Webqq\Message\Remote\_send_message.pm \
	  lib/Mojo/Webqq/Message/Remote/_send_sess_message.pm blib\lib\Mojo\Webqq\Message\Remote\_send_sess_message.pm \
	  lib/Mojo/Webqq/Message/Send/DiscussMessage.pm blib\lib\Mojo\Webqq\Message\Send\DiscussMessage.pm \
	  lib/Mojo/Webqq/Message/Send/GroupMessage.pm blib\lib\Mojo\Webqq\Message\Send\GroupMessage.pm \
	  lib/Mojo/Webqq/Message/Send/Message.pm blib\lib\Mojo\Webqq\Message\Send\Message.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e "pm_to_blib({{@ARGV}}, '$(INST_LIB)\auto', q[$(PM_FILTER)], '$(PERM_DIR)')" -- \
	  lib/Mojo/Webqq/Message/Send/SessMessage.pm blib\lib\Mojo\Webqq\Message\Send\SessMessage.pm \
	  lib/Mojo/Webqq/Message/Send/Status.pm blib\lib\Mojo\Webqq\Message\Send\Status.pm \
	  lib/Mojo/Webqq/Message/XMLescape.pm blib\lib\Mojo\Webqq\Message\XMLescape.pm \
	  lib/Mojo/Webqq/Model.pm blib\lib\Mojo\Webqq\Model.pm \
	  lib/Mojo/Webqq/Model/Base.pm blib\lib\Mojo\Webqq\Model\Base.pm \
	  lib/Mojo/Webqq/Model/Remote/_get_discuss_info.pm blib\lib\Mojo\Webqq\Model\Remote\_get_discuss_info.pm \
	  lib/Mojo/Webqq/Model/Remote/_get_discuss_list_info.pm blib\lib\Mojo\Webqq\Model\Remote\_get_discuss_list_info.pm \
	  lib/Mojo/Webqq/Model/Remote/_get_friend_info.pm blib\lib\Mojo\Webqq\Model\Remote\_get_friend_info.pm \
	  lib/Mojo/Webqq/Model/Remote/_get_friends_state.pm blib\lib\Mojo\Webqq\Model\Remote\_get_friends_state.pm \
	  lib/Mojo/Webqq/Model/Remote/_get_group_info.pm blib\lib\Mojo\Webqq\Model\Remote\_get_group_info.pm \
	  lib/Mojo/Webqq/Model/Remote/_get_group_info_ext.pm blib\lib\Mojo\Webqq\Model\Remote\_get_group_info_ext.pm \
	  lib/Mojo/Webqq/Model/Remote/_get_group_list_info.pm blib\lib\Mojo\Webqq\Model\Remote\_get_group_list_info.pm \
	  lib/Mojo/Webqq/Model/Remote/_get_group_list_info_ext.pm blib\lib\Mojo\Webqq\Model\Remote\_get_group_list_info_ext.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e "pm_to_blib({{@ARGV}}, '$(INST_LIB)\auto', q[$(PM_FILTER)], '$(PERM_DIR)')" -- \
	  lib/Mojo/Webqq/Model/Remote/_get_recent_info.pm blib\lib\Mojo\Webqq\Model\Remote\_get_recent_info.pm \
	  lib/Mojo/Webqq/Model/Remote/_get_user_friends.pm blib\lib\Mojo\Webqq\Model\Remote\_get_user_friends.pm \
	  lib/Mojo/Webqq/Model/Remote/_get_user_friends_ext.pm blib\lib\Mojo\Webqq\Model\Remote\_get_user_friends_ext.pm \
	  lib/Mojo/Webqq/Model/Remote/_get_user_info.pm blib\lib\Mojo\Webqq\Model\Remote\_get_user_info.pm \
	  lib/Mojo/Webqq/Model/Remote/_invite_friend.pm blib\lib\Mojo\Webqq\Model\Remote\_invite_friend.pm \
	  lib/Mojo/Webqq/Model/Remote/_kick_group_member.pm blib\lib\Mojo\Webqq\Model\Remote\_kick_group_member.pm \
	  lib/Mojo/Webqq/Model/Remote/_remove_group_admin.pm blib\lib\Mojo\Webqq\Model\Remote\_remove_group_admin.pm \
	  lib/Mojo/Webqq/Model/Remote/_set_group_admin.pm blib\lib\Mojo\Webqq\Model\Remote\_set_group_admin.pm \
	  lib/Mojo/Webqq/Model/Remote/_set_group_member_card.pm blib\lib\Mojo\Webqq\Model\Remote\_set_group_member_card.pm \
	  lib/Mojo/Webqq/Model/Remote/_shutup_group_member.pm blib\lib\Mojo\Webqq\Model\Remote\_shutup_group_member.pm \
	  lib/Mojo/Webqq/Model/Remote/get_qq_from_id.pm blib\lib\Mojo\Webqq\Model\Remote\get_qq_from_id.pm \
	  lib/Mojo/Webqq/Model/Remote/get_single_long_nick.pm blib\lib\Mojo\Webqq\Model\Remote\get_single_long_nick.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e "pm_to_blib({{@ARGV}}, '$(INST_LIB)\auto', q[$(PM_FILTER)], '$(PERM_DIR)')" -- \
	  lib/Mojo/Webqq/Plugin.pm blib\lib\Mojo\Webqq\Plugin.pm \
	  lib/Mojo/Webqq/Plugin/BadLanguage.pm blib\lib\Mojo\Webqq\Plugin\BadLanguage.pm \
	  lib/Mojo/Webqq/Plugin/Bayes.pm blib\lib\Mojo\Webqq\Plugin\Bayes.pm \
	  lib/Mojo/Webqq/Plugin/Cartoon.pm blib\lib\Mojo\Webqq\Plugin\Cartoon.pm \
	  lib/Mojo/Webqq/Plugin/Curl.pm blib\lib\Mojo\Webqq\Plugin\Curl.pm \
	  lib/Mojo/Webqq/Plugin/Domain.pm blib\lib\Mojo\Webqq\Plugin\Domain.pm \
	  lib/Mojo/Webqq/Plugin/ExchangeRate.pm blib\lib\Mojo\Webqq\Plugin\ExchangeRate.pm \
	  lib/Mojo/Webqq/Plugin/Express.pm blib\lib\Mojo\Webqq\Plugin\Express.pm \
	  lib/Mojo/Webqq/Plugin/FuckDaShen.pm blib\lib\Mojo\Webqq\Plugin\FuckDaShen.pm \
	  lib/Mojo/Webqq/Plugin/GroupManage.pm blib\lib\Mojo\Webqq\Plugin\GroupManage.pm \
	  lib/Mojo/Webqq/Plugin/IRCShell.pm blib\lib\Mojo\Webqq\Plugin\IRCShell.pm \
	  lib/Mojo/Webqq/Plugin/JavaCode.pm blib\lib\Mojo\Webqq\Plugin\JavaCode.pm \
	  lib/Mojo/Webqq/Plugin/KnowledgeBase.pm blib\lib\Mojo\Webqq\Plugin\KnowledgeBase.pm \
	  lib/Mojo/Webqq/Plugin/Lottery.pm blib\lib\Mojo\Webqq\Plugin\Lottery.pm \
	  lib/Mojo/Webqq/Plugin/MobileInfo.pm blib\lib\Mojo\Webqq\Plugin\MobileInfo.pm \
	  lib/Mojo/Webqq/Plugin/Monitor.pm blib\lib\Mojo\Webqq\Plugin\Monitor.pm \
	  lib/Mojo/Webqq/Plugin/MsgSync.pm blib\lib\Mojo\Webqq\Plugin\MsgSync.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e "pm_to_blib({{@ARGV}}, '$(INST_LIB)\auto', q[$(PM_FILTER)], '$(PERM_DIR)')" -- \
	  lib/Mojo/Webqq/Plugin/Openqq.pm blib\lib\Mojo\Webqq\Plugin\Openqq.pm \
	  lib/Mojo/Webqq/Plugin/Perlcode.pm blib\lib\Mojo\Webqq\Plugin\Perlcode.pm \
	  lib/Mojo/Webqq/Plugin/Perldoc.pm blib\lib\Mojo\Webqq\Plugin\Perldoc.pm \
	  lib/Mojo/Webqq/Plugin/Poetry.pm blib\lib\Mojo\Webqq\Plugin\Poetry.pm \
	  lib/Mojo/Webqq/Plugin/PostImgVerifycode.pm blib\lib\Mojo\Webqq\Plugin\PostImgVerifycode.pm \
	  lib/Mojo/Webqq/Plugin/PostQRcode.pm blib\lib\Mojo\Webqq\Plugin\PostQRcode.pm \
	  lib/Mojo/Webqq/Plugin/ProgramCode.pm blib\lib\Mojo\Webqq\Plugin\ProgramCode.pm \
	  lib/Mojo/Webqq/Plugin/PushPlug.pm blib\lib\Mojo\Webqq\Plugin\PushPlug.pm \
	  lib/Mojo/Webqq/Plugin/QQMsgSync.pm blib\lib\Mojo\Webqq\Plugin\QQMsgSync.pm \
	  lib/Mojo/Webqq/Plugin/Questions.pm blib\lib\Mojo\Webqq\Plugin\Questions.pm \
	  lib/Mojo/Webqq/Plugin/RedisDoc.pm blib\lib\Mojo\Webqq\Plugin\RedisDoc.pm \
	  lib/Mojo/Webqq/Plugin/SearchEngine.pm blib\lib\Mojo\Webqq\Plugin\SearchEngine.pm \
	  lib/Mojo/Webqq/Plugin/ShowMsg.pm blib\lib\Mojo\Webqq\Plugin\ShowMsg.pm \
	  lib/Mojo/Webqq/Plugin/SleepRecord.pm blib\lib\Mojo\Webqq\Plugin\SleepRecord.pm \
	  lib/Mojo/Webqq/Plugin/SmartReply.pm blib\lib\Mojo\Webqq\Plugin\SmartReply.pm \
	  lib/Mojo/Webqq/Plugin/SongKTV.pm blib\lib\Mojo\Webqq\Plugin\SongKTV.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e "pm_to_blib({{@ARGV}}, '$(INST_LIB)\auto', q[$(PM_FILTER)], '$(PERM_DIR)')" -- \
	  lib/Mojo/Webqq/Plugin/SongWord.pm blib\lib\Mojo\Webqq\Plugin\SongWord.pm \
	  lib/Mojo/Webqq/Plugin/SparkShell.pm blib\lib\Mojo\Webqq\Plugin\SparkShell.pm \
	  lib/Mojo/Webqq/Plugin/StockInfo.pm blib\lib\Mojo\Webqq\Plugin\StockInfo.pm \
	  lib/Mojo/Webqq/Plugin/Translation.pm blib\lib\Mojo\Webqq\Plugin\Translation.pm \
	  lib/Mojo/Webqq/Plugin/Wisdom.pm blib\lib\Mojo\Webqq\Plugin\Wisdom.pm \
	  lib/Mojo/Webqq/Plugin/Wooyun.pm blib\lib\Mojo\Webqq\Plugin\Wooyun.pm \
	  lib/Mojo/Webqq/Plugin/ZhiBo8.pm blib\lib\Mojo\Webqq\Plugin\ZhiBo8.pm \
	  lib/Mojo/Webqq/Plugin/sleep.txt blib\lib\Mojo\Webqq\Plugin\sleep.txt \
	  lib/Mojo/Webqq/Recent/Discuss.pm blib\lib\Mojo\Webqq\Recent\Discuss.pm \
	  lib/Mojo/Webqq/Recent/Friend.pm blib\lib\Mojo\Webqq\Recent\Friend.pm \
	  lib/Mojo/Webqq/Recent/Group.pm blib\lib\Mojo\Webqq\Recent\Group.pm \
	  lib/Mojo/Webqq/Request.pm blib\lib\Mojo\Webqq\Request.pm \
	  lib/Mojo/Webqq/Run.pm blib\lib\Mojo\Webqq\Run.pm \
	  lib/Mojo/Webqq/Server.pm blib\lib\Mojo\Webqq\Server.pm \
	  lib/Mojo/Webqq/User.pm blib\lib\Mojo\Webqq\User.pm \
	  lib/Mojo/Webqq/Util.pm blib\lib\Mojo\Webqq\Util.pm 
	$(NOECHO) $(TOUCH) pm_to_blib


# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:


# End.
