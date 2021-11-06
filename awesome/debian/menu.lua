-- automatically generated file. Do not edit (see /usr/share/doc/menu/html)

module("debian.menu")

Debian_menu = {}

Debian_menu["Debian_帮助"] = {
	{"Info", "x-terminal-emulator -e ".."info"},
	{"Xman","xman"},
	{"yelp","/usr/bin/yelp"},
}
Debian_menu["Debian_应用程序_Shell"] = {
	{"Bash", "x-terminal-emulator -e ".."/bin/bash --login"},
	{"Dash", "x-terminal-emulator -e ".."/bin/dash -i"},
	{"Sh", "x-terminal-emulator -e ".."/bin/sh --login"},
}
Debian_menu["Debian_应用程序_办公"] = {
	{"FreeMind","/usr/bin/freemind","/usr/share/pixmaps/FreeMindWindowIcon.xpm"},
	{"HPLIP Fax address book","/usr/bin/hp-fab","/usr/share/pixmaps/HPmenu.xpm"},
	{"HPLIP Fax utility","/usr/bin/hp-sendfax","/usr/share/pixmaps/HPmenu.xpm"},
	{"OpenOffice.org Calc","/usr/bin/oocalc","/usr/share/icons/hicolor/32x32/apps/openofficeorg3-calc.xpm"},
	{"OpenOffice.org Impress","/usr/bin/ooimpress","/usr/share/icons/hicolor/32x32/apps/openofficeorg3-impress.xpm"},
	{"OpenOffice.org Writer","/usr/bin/oowriter","/usr/share/icons/hicolor/32x32/apps/openofficeorg3-writer.xpm"},
}
Debian_menu["Debian_应用程序_编程"] = {
	{"Erlang Shell", "x-terminal-emulator -e ".."/usr/bin/erl","/usr/share/pixmaps/erlang.xpm"},
	{"GDB", "x-terminal-emulator -e ".."/usr/bin/gdb"},
	{"Meld","/usr/bin/meld"},
	{"Mozart","/usr/bin/oz","/usr/share/pixmaps/mozart32.xpm"},
	{"Ocaml", "x-terminal-emulator -e ".."/usr/bin/ocaml","/usr/share/pixmaps/ocaml.xpm"},
	{"pycrust","/usr/bin/pycrust","/usr/share/pixmaps/pycrust.png"},
	{"pyshell","/usr/bin/pyshell","/usr/share/pixmaps/pyshell.png"},
	{"Python (v2.6)", "x-terminal-emulator -e ".."/usr/bin/python2.6","/usr/share/pixmaps/python2.6.xpm"},
	{"Ruby (irb1.8)", "x-terminal-emulator -e ".."/usr/bin/irb1.8"},
	{"Ruby (irb1.9.1)", "x-terminal-emulator -e ".."/usr/bin/irb1.9.1"},
	{"Tclsh8.4", "x-terminal-emulator -e ".."/usr/bin/tclsh8.4"},
	{"Tclsh8.5", "x-terminal-emulator -e ".."/usr/bin/tclsh8.5"},
	{"TkWish8.4","x-terminal-emulator -e /usr/bin/wish8.4"},
	{"TkWish8.5","x-terminal-emulator -e /usr/bin/wish8.5"},
	{"xrced","/usr/bin/xrced","/usr/share/pixmaps/xrced.png"},
}
Debian_menu["Debian_应用程序_编辑器"] = {
	{"Emacs 22 (text)", "x-terminal-emulator -e ".."/usr/bin/emacs22 -nw","/usr/share/emacs/22.2/etc/emacs.xpm"},
	{"Emacs 22 (X11)","/usr/bin/emacs22-x","/usr/share/emacs/22.2/etc/emacs.xpm"},
	{"Gedit","/usr/bin/gedit","/usr/share/pixmaps/gedit-icon.xpm"},
	{"Nano", "x-terminal-emulator -e ".."/bin/nano","/usr/share/nano/nano-menu.xpm"},
	{"Xedit","xedit"},
	{"xournal","/usr/bin/xournal"},
}
Debian_menu["Debian_应用程序_查看器"] = {
	{"comix","/usr/bin/comix"},
	{"Evince","/usr/bin/evince","/usr/share/pixmaps/evince.xpm"},
	{"Eye of GNOME","/usr/bin/eog","/usr/share/pixmaps/gnome-eog.xpm"},
	{"F-Spot","/usr/bin/f-spot"},
	{"Xditview","xditview"},
}
Debian_menu["Debian_应用程序_辅助工具"] = {
	{"Xmag","xmag"},
}
Debian_menu["Debian_应用程序_科学_数学"] = {
	{"Bc", "x-terminal-emulator -e ".."/usr/bin/bc"},
	{"Dc", "x-terminal-emulator -e ".."/usr/bin/dc"},
	{"GCalcTool","/usr/bin/gcalctool","/usr/share/pixmaps/gcalctool.xpm"},
	{"OpenOffice.org Math","/usr/bin/oomath","/usr/share/icons/hicolor/32x32/apps/openofficeorg3-math.xpm"},
	{"Xcalc","xcalc"},
}
Debian_menu["Debian_应用程序_科学"] = {
	{ "数学", Debian_menu["Debian_应用程序_科学_数学"] },
}
Debian_menu["Debian_应用程序_声音"] = {
	{"Alsamixergui","/usr/bin/alsamixergui","/usr/share/pixmaps/alsamixergui.xpm"},
	{"Amarok","/usr/bin/amarok"},
	{"aumix", "x-terminal-emulator -e ".."/usr/bin/aumix","/usr/share/pixmaps/icon_aumix.xpm"},
	{"Deadbeef","/usr/bin/deadbeef"},
	{"gmix (Gnome 2.0 Mixer)","/usr/bin/gnome-volume-control","/usr/share/pixmaps/gnome-mixer.xpm"},
	{"grecord (GNOME 2.0 Recorder)","/usr/bin/gnome-sound-recorder","/usr/share/pixmaps/gnome-grecord.xpm"},
	{"Rhythmbox","/usr/bin/rhythmbox","/usr/share/pixmaps/rhythmbox-small.xpm"},
}
Debian_menu["Debian_应用程序_视频"] = {
	{"Totem","/usr/bin/totem","/usr/share/pixmaps/totem.xpm"},
}
Debian_menu["Debian_应用程序_数据管理"] = {
	{"Tomboy","/usr/bin/tomboy"},
}
Debian_menu["Debian_应用程序_图形"] = {
	{"GNOME Screenshot Tool","/usr/bin/gnome-panel-screenshot"},
	{"ImageMagick","/usr/bin/display logo:","/usr/share/pixmaps/display.xpm"},
	{"OpenOffice.org Draw","/usr/bin/oodraw","/usr/share/icons/hicolor/32x32/apps/openofficeorg3-draw.xpm"},
	{"X Window Snapshot","xwd | xwud"},
}
Debian_menu["Debian_应用程序_网络_通信"] = {
	{"Evolution","/usr/bin/evolution","/usr/share/pixmaps/evolution.xpm"},
	{"Minicom", "x-terminal-emulator -e ".."/usr/bin/minicom"},
	{"Minicom (X11)","/usr/bin/xminicom"},
	{"Telnet", "x-terminal-emulator -e ".."/usr/bin/telnet"},
	{"Terminal Server Client","/usr/bin/tsclient -f","/usr/share/pixmaps/tsclient.xpm"},
	{"Xbiff","xbiff"},
}
Debian_menu["Debian_应用程序_网络_网络浏览"] = {
	{"Firefox Browser","/usr/bin/firefox","/usr/share/pixmaps/firefox.png"},
	{"Midori","midori"},
	{"w3m", "x-terminal-emulator -e ".."/usr/bin/w3m /usr/share/doc/w3m/MANUAL.html"},
}
Debian_menu["Debian_应用程序_网络_文件传输"] = {
	{"KTorrent","ktorrent","/usr/share/pixmaps/ktorrent.xpm"},
	{"Transmission BitTorrent Client (GTK)","/usr/bin/transmission","/usr/share/pixmaps/transmission.xpm"},
}
Debian_menu["Debian_应用程序_网络_系统监控"] = {
	{"ettercap","/usr/sbin/ettercap --gtk"},
	{"ettercap (as root)","su-to-root -X -c \"/usr/sbin/ettercap --gtk\""},
	{"Firestarter","su-to-root -X -c /usr/sbin/firestarter","/usr/share/pixmaps/firestarter.xpm"},
	{"WICD","/usr/bin/wicd-gtk","/usr/share/pixmaps/wicd-gtk.xpm"},
}
Debian_menu["Debian_应用程序_网络"] = {
	{ "通信", Debian_menu["Debian_应用程序_网络_通信"] },
	{ "网络浏览", Debian_menu["Debian_应用程序_网络_网络浏览"] },
	{ "文件传输", Debian_menu["Debian_应用程序_网络_文件传输"] },
	{ "系统监控", Debian_menu["Debian_应用程序_网络_系统监控"] },
}
Debian_menu["Debian_应用程序_文本"] = {
	{"Character map","/usr/bin/gucharmap"},
	{"GNOME Dictionary","/usr/bin/gnome-dictionary","/usr/share/pixmaps/gdict.xpm"},
	{"stardict","/usr/bin/stardict","/usr/share/pixmaps/stardict_32x32.xpm"},
}
Debian_menu["Debian_应用程序_文件管理"] = {
	{"Baobab","/usr/bin/baobab","/usr/share/pixmaps/baobab.xpm"},
	{"Brasero","/usr/bin/brasero"},
	{"File-Roller","/usr/bin/file-roller","/usr/share/pixmaps/file-roller.xpm"},
	{"Gentoo","gentoo"},
	{"GNOME Search Tool","/usr/bin/gnome-search-tool","/usr/share/pixmaps/gsearchtool.xpm"},
	{"K3b","/usr/bin/k3b","/usr/share/pixmaps/k3b.xpm"},
	{"mc", "x-terminal-emulator -e ".."/usr/bin/mc","/usr/share/pixmaps/mc.xpm"},
	{"Nautilus","/usr/bin/nautilus","/usr/share/pixmaps/nautilus.xpm"},
}
Debian_menu["Debian_应用程序_系统_安全"] = {
	{"Seahorse","/usr/bin/seahorse","/usr/share/pixmaps/seahorse.xpm"},
}
Debian_menu["Debian_应用程序_系统_管理"] = {
	{"Aptitude", "x-terminal-emulator -e ".."/usr/bin/aptitude"},
	{"Compiz Fusion Icon","/usr/bin/fusion-icon","/usr/share/pixmaps/fusion-icon.xpm"},
	{"Debian Task selector", "x-terminal-emulator -e ".."su-to-root -c tasksel"},
	{"DSL/PPPoE configuration tool", "x-terminal-emulator -e ".."/usr/sbin/pppoeconf","/usr/share/pixmaps/pppoeconf.xpm"},
	{"Editres","editres"},
	{"Gnome Control Center","/usr/bin/gnome-control-center","/usr/share/pixmaps/control-center2.xpm"},
	{"GNOME Network Tool","/usr/bin/gnome-nettool","/usr/share/pixmaps/gnome-nettool.xpm"},
	{"HPLIP File printing","/usr/bin/hp-print","/usr/share/pixmaps/HPmenu.xpm"},
	{"OpenJDK Java 6 Policy Tool","/usr/lib/jvm/java-6-openjdk/bin/policytool","/usr/share/pixmaps/openjdk-6.xpm"},
	{"pppconfig", "x-terminal-emulator -e ".."su-to-root -p root -c /usr/sbin/pppconfig"},
	{"Shares Admin","/usr/bin/shares-admin","/usr/share/gnome-system-tools/pixmaps/shares.xpm"},
	{"Startup-Manager","su-to-root -X -c /usr/sbin/startupmanager"},
	{"Time Admin","/usr/bin/time-admin","/usr/share/gnome-system-tools/pixmaps/time.xpm"},
	{"User accounts Admin","/usr/bin/users-admin","/usr/share/gnome-system-tools/pixmaps/users.xpm"},
	{"Xclipboard","xclipboard"},
	{"Xfontsel","xfontsel"},
	{"Xkill","xkill"},
	{"Xrefresh","xrefresh"},
}
Debian_menu["Debian_应用程序_系统_软件包管理"] = {
	{"Synaptic Package Manager","/usr/bin/gksu /usr/sbin/synaptic","/usr/share/synaptic/pixmaps/synaptic_32x32.xpm"},
}
Debian_menu["Debian_应用程序_系统_系统监控"] = {
	{"GNOME Log Viewer","/usr/bin/gnome-system-log","/usr/share/pixmaps/gnome-system-log.xpm"},
	{"GNOME system monitor","/usr/bin/gnome-system-monitor"},
	{"htop", "x-terminal-emulator -e ".."/usr/bin/htop"},
	{"Pstree", "x-terminal-emulator -e ".."/usr/bin/pstree.x11","/usr/share/pixmaps/pstree16.xpm"},
	{"Top", "x-terminal-emulator -e ".."/usr/bin/top"},
	{"Xconsole","xconsole -file /dev/xconsole"},
	{"Xev","x-terminal-emulator -e xev"},
	{"Xload","xload"},
}
Debian_menu["Debian_应用程序_系统_硬件"] = {
	{"HPLIP Toolbox","/usr/bin/hp-toolbox","/usr/share/pixmaps/HPmenu.xpm"},
	{"Xvidtune","xvidtune"},
}
Debian_menu["Debian_应用程序_系统_语言环境"] = {
	{"im-switch", "x-terminal-emulator -e ".."/usr/bin/im-switch"},
}
Debian_menu["Debian_应用程序_系统"] = {
	{"ROX Filer","/usr/bin/rox"},
	{ "安全", Debian_menu["Debian_应用程序_系统_安全"] },
	{ "管理", Debian_menu["Debian_应用程序_系统_管理"] },
	{ "软件包管理", Debian_menu["Debian_应用程序_系统_软件包管理"] },
	{ "系统监控", Debian_menu["Debian_应用程序_系统_系统监控"] },
	{ "硬件", Debian_menu["Debian_应用程序_系统_硬件"] },
	{ "语言环境", Debian_menu["Debian_应用程序_系统_语言环境"] },
}
Debian_menu["Debian_应用程序_终端"] = {
	{"Gnome Terminal","/usr/bin/gnome-terminal","/usr/share/pixmaps/gnome-terminal.xpm"},
	{"XTerm","xterm","/usr/share/pixmaps/xterm-color_32x32.xpm"},
	{"X-Terminal as root (GKsu)","/usr/bin/gksu -u root /usr/bin/x-terminal-emulator","/usr/share/pixmaps/gksu-debian.xpm"},
	{"XTerm (Unicode)","uxterm","/usr/share/pixmaps/xterm-color_32x32.xpm"},
}
Debian_menu["Debian_应用程序"] = {
	{ "Shell", Debian_menu["Debian_应用程序_Shell"] },
	{ "办公", Debian_menu["Debian_应用程序_办公"] },
	{ "编程", Debian_menu["Debian_应用程序_编程"] },
	{ "编辑器", Debian_menu["Debian_应用程序_编辑器"] },
	{ "查看器", Debian_menu["Debian_应用程序_查看器"] },
	{ "辅助工具", Debian_menu["Debian_应用程序_辅助工具"] },
	{ "科学", Debian_menu["Debian_应用程序_科学"] },
	{ "声音", Debian_menu["Debian_应用程序_声音"] },
	{ "视频", Debian_menu["Debian_应用程序_视频"] },
	{ "数据管理", Debian_menu["Debian_应用程序_数据管理"] },
	{ "图形", Debian_menu["Debian_应用程序_图形"] },
	{ "网络", Debian_menu["Debian_应用程序_网络"] },
	{ "文本", Debian_menu["Debian_应用程序_文本"] },
	{ "文件管理", Debian_menu["Debian_应用程序_文件管理"] },
	{ "系统", Debian_menu["Debian_应用程序_系统"] },
	{ "终端", Debian_menu["Debian_应用程序_终端"] },
}
Debian_menu["Debian_游戏_动作类"] = {
	{"Chromium B.S.U.","/usr/games/chromium-bsu","/usr/share/pixmaps/chromium-bsu.xpm"},
	{"Hedgewars","/usr/games/hedgewars"},
	{"SuperTux","/usr/games/supertux2 --disable-sfx --disable-music","/usr/share/games/supertux2/images/engine/icons/supertux.xpm"},
	{"Supertuxkart","supertuxkart","/usr/share/icons/hicolor/32x32/apps/supertuxkart.xpm"},
}
Debian_menu["Debian_游戏_迷宫类"] = {
	{"gbrainy","/usr/games/gbrainy","/usr/share/pixmaps/gbrainy.xpm"},
	{"Gnome Sudoku","/usr/games/gnome-sudoku","/usr/share/pixmaps/gnome-sudoku.xpm"},
	{"Gnomine","/usr/games/gnomine","/usr/share/pixmaps/gnomine.xpm"},
	{"Quadrapassel","/usr/games/quadrapassel","/usr/share/pixmaps/quadrapassel.xpm"},
}
Debian_menu["Debian_游戏_棋盘类"] = {
	{"Gnome Mahjongg","/usr/games/mahjongg","/usr/share/pixmaps/mahjongg.xpm"},
}
Debian_menu["Debian_游戏_玩具类"] = {
	{"Oclock","oclock"},
	{"Xclock (analog)","xclock -analog"},
	{"Xclock (digital)","xclock -digital -update 1"},
	{"Xeyes","xeyes"},
	{"Xlogo","xlogo"},
}
Debian_menu["Debian_游戏_纸牌类"] = {
	{"Gnome FreeCell","/usr/games/sol --variation freecell",},
	{"Gnome Solitaire Games","/usr/games/sol","/usr/share/pixmaps/aisleriot.xpm"},
}
Debian_menu["Debian_游戏"] = {
	{ "动作类", Debian_menu["Debian_游戏_动作类"] },
	{ "迷宫类", Debian_menu["Debian_游戏_迷宫类"] },
	{ "棋盘类", Debian_menu["Debian_游戏_棋盘类"] },
	{ "玩具类", Debian_menu["Debian_游戏_玩具类"] },
	{ "纸牌类", Debian_menu["Debian_游戏_纸牌类"] },
}
Debian_menu["Debian"] = {
	{ "帮助", Debian_menu["Debian_帮助"] },
	{ "应用程序", Debian_menu["Debian_应用程序"] },
	{ "游戏", Debian_menu["Debian_游戏"] },
}
