#!/bin/sh

export HOME=/home/user
export USER=`whoami`
export LANG=en_IL
export JAVA_HOME=/usr/lib/jvm/default-java
mkdir -m 1777 /tmp/.X11-unix
Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile ./0.log -config ./xorg.conf :0 &
sleep 5s
DISPLAY=:0 openbox-session &
sleep 5s
DISPLAY=:0 lxterminal &
xauth generate :0 . trusted
DISPLAY=:0 x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth ~/.vnc/passwd -rfbport 5900 -shared &
printf "%s\n" "$HEROKU_LOGIN" > .netrc
#pg_createcluster -u `whoami` 10 main
#sed -i "s/install -d -m 2775 -o postgres -g postgres \/var\/run\/postgresql/install -d -m 2775 -o `whoami` -g `id -gn` \/var\/run\/postgresql/" /usr/share/postgresql-common/init.d-functions
echo "mymap           `whoami`                  postgres" >> /etc/postgresql/10/main/pg_ident.conf
service postgresql start
#sleep 5s
#createdb
env > env
