#!/bin/sh

#touch /tmp/X11-unix
export DOLLAR='$'
export HOME=/home/user
export USER=`whoami`
export LANG=en_IL
envsubst < nginx.template > /etc/nginx/sites-enabled/default
touch /opt/noVNC/`whoami`
cd /opt/noVNC && ./utils/launch.sh &
#sleep 5s
/opt/noVNC/utils/websockify/run 8080 localhost:2200 --heartbeat=45 &
#sleep 5s
/usr/sbin/sshd -p 2200 -o AuthorizedKeysFile=/home/user/.ssh/authorized_keys &
nginx -g 'daemon off;'
