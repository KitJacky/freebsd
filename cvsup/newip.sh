#!/bin/bash
#
# 2002

# set variables
if echo $0 | grep '^/' ; then
    w_dir=${0%/*}
else
    w_dir=$PWD/${0%/*}
fi
KEY_FILE=$w_dir/Kmail.+157+44587.key
UPDATE_SCR=$w_dir/nsupdate.scr
UPDATE_DATA=$w_dir/nsupdate.data
HOST_NAME=mail.example.com
NS_SERVER=ns.example.com
IF="ppp0"

# ensure key files
for file in $KEY_FILE ${KEY_FILE%key}private
do
    if [ ! -r $file ]; then
        echo "$(basename $0): ERROR: $file is not readable."
        exit 1
    fi
done

# prepare initial script
test -f $UPDATE_SCR || {
    cat >| $UPDATE_SCR <<-ENDSCR
            server NS_SERVER
            update delete HOST_NAME A
            update add HOST_NAME 0 A NEW_IP
            send
	ENDSCR
    test "$?" = "0" || {
        echo "$(basename $0): ERROR: could not create $UPDATE_SCR."
        exit 2
    }
}

# ensure the server is connectable
host $NS_SERVER $NS_SERVER | grep "$NS_SERVER" &>/dev/null || {
    echo "$(basename $0): ERROR: could not contact nameserver $NS_SERVER."
    exit 3
}

# get current ip
NEW_IP=$(ifconfig | grep "$IF " -A 1 \
    | awk '/inet/ {print $2}' | sed -e 's/.*://')

# do a test then update
host $HOST_NAME $NS_SERVER | grep "$NEW_IP" &>/dev/null || {
    /bin/cat $UPDATE_SCR | sed s/NEW_IP/$NEW_IP/ \
        | sed s/NS_SERVER/$NS_SERVER/ \
        | sed s/HOST_NAME/$HOST_NAME/ \
        >| $UPDATE_DATA
    /usr/bin/nsupdate -k $KEY_FILE -v $UPDATE_DATA || rm -rf $UPDATE_DATA
}
