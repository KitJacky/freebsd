#!/bin/sh

#install.sh 
#JK DNEWS WEB ADMIN SYSTEM INSTALL SCRIPT.
#JK Dnews admin system is Free Software released under the GNU/GPL license. 
# Powered By Ho Chi Kit, JackyKit. 2001 - 2003   
# Version 0.4  03-2003
# Email : admin@3jk.com

LOGFILE="jkinstall.log"

clear



echo -e "\\033[1;37m""Welcome to JK System""\\033[0;39m"
echo -e "\\033[1;37m""JK DNEWS WEB ADMIN SYSTEM INSTALL Program""\\033[0;39m"
echo "-------------------------------------------------------"  >> $LOGFILE
echo "INSTALL JK DNEWS WEB ADMIN SYSTEM"  >> $LOGFILE
date >> $LOGFILE
echo -e "\\033[1;32m""Install DNEWS WEB ADMIN SYSTEM..........""\\033[0;39m"
echo -e "\\033[1;34m""-------------------------------------------------------""\\033[0;39m"
echo -e "\\033[1;33m"Checking...."\\033[0;39m" 
id | grep "uid=0(" >/dev/null
if [ $? != "0" ]; then
  uname -a | grep -i CYGWIN >/dev/null
  if [ $? != "0" ]; then
    echo  -e "\\033[0;35m""[Sorry, The JK install script must be run as ROOT]""\\033[0;39m";
    echo " [Sorry, The JK install script must be run as ROOT]" >> $LOGFILE
    echo "";
    exit 0;
  fi
fi
echo -n "  Checking for dnews ..... "
if [ -x /usr/bin/tellnews ] || [ -x /usr/local/bin/tellnews ]; then
echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"
JKINIT()
{
case "`echo 'x\c'`" in
   'x\c')   echo="echo -n"    nnl= ;;
   x)       echo="echo"       nnl="\c" ;;
   *)       echo "$0 quitting:  Can't set up echo." ; exit 1 ;;
esac

JKAN 'yYnN' " Install JK DNews Admin System? (y/n)" "N"
 if [ $answer = n ] || [ $answer = N ]
 then
   echo -e "\\033[0;37m"byebye!! ^^ "\\033[0;39m"
   exit 0
 fi
 echo
}

JKAN()
{
 answer="|"
 until echo $1 | grep $answer >/dev/null
 do
    $echo "${2} [${3}]?  ${nnl}"
    read answer
    if [ "$3" != "" ] && [ "$answer" = "" ]
    then
       answer=$3
    fi
 done
}
JKINIT
echo
echo -n " setting ....."
ln -s /var/spool/dnews/work/filter.dat /usr/local/dnews/filter.dat
touch /usr/local/dnews/post.add_jk
touch /usr/local/dnews/filter.dat_jk
sleep 1
echo -n ".."
cp -Rf server/jkfilter.pl server/jk.pl /usr/local/dnews
cp -Rf server/dnews_start.sh /usr/local/dnews
sleep 1
echo -n ".."
chown news:news /usr/local/dnews/post.add_jk
chown news:news /usr/local/dnews/filter.dat_jk
sleep 1
echo -n ".."
chown news:news /usr/local/dnews/jk.pl
chown news:news /usr/local/dnews/jkfilter.pl
sleep 1
echo -n ".."
chown news:news /usr/local/dnews/dnews_start.sh
chmod 700 /usr/bin/tellnews
sleep 1
echo -n ".."
chmod 700 /usr/local/dnews/jk.pl
chmod 700 /usr/local/dnews/jkfilter.pl
sleep 1
echo -n ".."
echo
echo -e "\\033[1;31m"Install Finish, PLS COPY ' web/* ' to your web location"\\033[0;39m"
echo "Install Finish, PLS COPY ' web/* ' to your web location" >> $LOGFILE
	else echo -e "\\033[1;35m""Can't Find [DNews Server]""\\033[0;39m"
	echo "Can't Find [DNews Server] , You not install DNews Server!" >> $LOGFILE
fi
echo
echo
echo FreeBSD and Linux JK DNews Admin System Install Script.
echo -e "\\033[1;31m"Powered By JackyKit. 2001-2003 Version 0.4.0"\\033[0;39m"
echo -e "\\033[1;31m"Email : admin@3jk.com Web Site : http://jkzone.net "\\033[0;39m"
echo
echo
