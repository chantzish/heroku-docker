#!/bin/sh

export HOME=/home/user
export USER=`whoami`
export LANG=en_IL
export JAVA_HOME=/opt/jdk1.6.0_45/
mkdir -m 1777 /tmp/.X11-unix
Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile ./0.log -config ./xorg.conf :0 &
sleep 5s
DISPLAY=:0 openbox-session &
sleep 5s
git clone https://github.com/chantzish/learn-android.git
mv learn-android workspace
DISPLAY=:0 eclipse &
DISPLAY=:0 lxterminal &
xauth generate :0 . trusted
DISPLAY=:0 x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth ~/.vnc/passwd -rfbport 5900 -shared &
printf "%s\n" "$HEROKU_LOGIN" > .netrc
