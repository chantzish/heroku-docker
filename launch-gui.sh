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
mkdir .vnc
x11vnc -storepasswd $VNC_PASS /home/user/.vnc/passwd
DISPLAY=:0 x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth ~/.vnc/passwd -rfbport 5900 -shared &
printf "%s\n" "$HEROKU_LOGIN" > .netrc
printf "%s\n" "$IDENTITY" > .ssh/id_rsa
sleep 40s
#DISPLAY=:0 xdotool search Problem key Tab
#sleep 10s
#DISPLAY=:0 xdotool search Problem key KP_Enter
#sleep 10s
#DISPLAY=:0 xdotool search Java key F5
DISPLAY=:0 xdotool search Problem windowclose
DISPLAY=:0 xdotool search Java windowclose
DISPLAY=:0 eclipse &
