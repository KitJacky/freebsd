#!/bin/sh
# df -k
#Filesystem           1K-blocks      Used Available Use% Mounted on
#/dev/sda2            113852040  10113912  97954732  10% /
#/dev/sda1               790588     24680    725748   4% /boot
#none                   1028008         0   1028008   0% /dev/shm
#/dev/sda5             19362784  10617104   7762104  58% /export/home
#
# to show how to set crontab
# [root@ad12 log]# crontab -l
# SHELL=/bin/bash
# 30 18 * * *       /usr/local/william.w/backup-1.sh >> /usr/local/william.w/backup.log 2>&1
#
# to avoid the error: TERM environment variable not set.
cd /
clear
echo
echo
echo =====================================
echo this tool is used to backup the MMSC
echo =====================================
# to get the IP
IP1=`ifconfig | grep "inet " | grep -v "inet 127.0.0.1" | awk '{printf $2}'`
IP2=${IP1%% *}
echo the server IP is $IP2
# to get the date
DATE=`date +%Y-%m-%d-%H`-tar
echo today is ${DATE%-*}
# to make a file folder to store the backp files, but if it was already exsit, just to overwirite it.
mkdir /jk/temp/$DATE 2> /dev/null
echo /jk/temp/$DATE has already exsited or been made.
echo and backup file will be backuped in this folder.
echo
# all backup files using tar file have been located in /export/home, and below command just sum the backup files and show them in the list.
NUM=`ls /jk/temp/ | grep tar | wc -l`
echo now we have $NUM tar folder, they are all under /jk/temp/
echo =================
ls -tr /jk/temp/ | grep tar
echo =================
# to caculate the used disk space for /export/home
USEDISK=`df -k |sed -n '/s1a/'p  | awk '{print $5}' |sed 's/\%//'`
        if [ $USEDISK -gt 85 ]
        then
        echo USEDISK is $USEDISK%
        echo WARNNIG: have no enough space to backup!
        exit;
        fi
echo USEDISK is $USEDISK%       
        if [ $USEDISK -gt 65 ]
                then
                echo "***************************"
                echo 'USEDISK is lager than 65!!!'
                if [ $NUM -gt 2 ]
                        then
                        echo "***************************"
                        echo there are $NUM tar folders:
                        ls -tr /jk/temp/ | grep tar
                        echo "*****************************************"
                        # if the used disk space is beyond 65% and the number of tar-format-backup-file-folder is bigger than 2, we would delete these folders to keep the number to be less or equate 2        
                        DIFF=`expr $NUM - 2`
                        # the number of file folders that would be deleted is $DIFF, and they would be deleted in below circle.
                        for dir in `ls -tr /jk/temp/ | grep tar | head -n $DIFF`
                                do
                                        DISKSPACE=`df -k |sed -n '/s1a/'p  | awk '{print $5}' |sed 's/\%//'`
                                        if [ $DISKSPACE -le 65 ]
                                        then
                                                echo now USEDISK is $DISKSPACE%, and it is OK
                                                break;
                                        fi
#                                        line = $dir;
                                        echo "`ls -tr /jk/temp/ | grep tar | head -n 1` will be deleted soon..."
                                        echo ...
                                        rm -fr /jk/temp/$dir;
                                        echo "$dir has been deleted successfully"
                                echo "-----------------------------------------------"                                       
                                done
                        echo "********************************"
                fi
        fi
echo
echo "==========Begin to tar=============="
echo now below file folder would be tared:
# just show the list of file folder that would be backuped, and folder name has been add with "/" becuase this RHEL4.0 X86-64 does not show the root path.
echo ------------------
ls / | grep -v -e proc -e mnt -e media -e lost+found -e jk -e dev| sed 's/\([]\{1,\}\)/\1\//g;s/^./\/&/g'
echo ------------------
echo tar is working now...
echo please waiting.......
# prepare to show the file name, and the backup file name is $DATE/$RNAME-$IP3-$DAY.tar.gz locating at /jk/temp/$DATE/
# to backup all root file folders,  but donot include /proc, /mnt, /media/, and /export
# all the display infomation would not show by  >& /dev/null
# all error information would not show by 2> /dev/null
IP3=`echo $IP2 | awk -F. '{printf $3"."$4}'`
DAY=`echo $DATE| awk -F- '{printf $2$3$4}'`
RNAME=`hostname | awk -F. '{printf $1}'`
tar -zcvPf /jk/temp/$DATE/$RNAME-$IP3-$DAY.tar.gz 2> /dev/null $(ls / | grep -v -e proc -e mnt -e media -e lost+found -e jk -e dev -e cdrom)  >& /dev/null
echo now backup is successful.
echo the file is /jk/temp/$DATE/$RNAME-$IP3-$DAY.tar.gz
echo "==================================End to tar========================="
echo
# to list the backup folders  
echo Summary of backup files:
echo -----------------------
echo the img backup:
ls -t /jk/temp/ | grep img
echo ------------------
echo the tar backup:
ls -t /jk/temp/ | grep tar
echo ------------------
echo other files:
ls -t /jk/temp/ | grep -v tar |grep -v img
echo =================================
USEDISK1=`df -k |sed -n '/export/'p  | awk '{print $5}' |sed 's/\%//'`
echo before backup the USEDISK is $USEDISK%
echo at last the USEDISK is $USEDISK1%
echo =================================
