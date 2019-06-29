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
xauth generate :0 . trusted
mkdir .vnc
x11vnc -storepasswd $VNC_PASS /home/user/.vnc/passwd
DISPLAY=:0 x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth ~/.vnc/passwd -rfbport 5900 -shared &
git clone https://github.com/chantzish/learn-android.git
#rm -rf workspace
mv learn-android workspace
DISPLAY=:0 eclipse &
DISPLAY=:0 lxterminal &
printf "%s\n" "$HEROKU_LOGIN" > .netrc
printf "%s" "$IDENTITY" > .ssh/id_rsa
yes "" | /opt/android-sdk/tools/android create avd -t android-5 -c 512M -n testy
DISPLAY=:0 /opt/android-sdk/tools/emulator -avd testy &
#sleep 23s
#DISPLAY=:0 xdotool search Problem windowfocus key Tab
#sleep 3s
#DISPLAY=:0 xdotool search Problem windowfocus key KP_Enter
#sleep 3s
#DISPLAY=:0 xdotool search Java windowfocus key F5
#DISPLAY=:0 xdotool search Problem windowclose
#DISPLAY=:0 xdotool search Java windowclose
#pkill eclipse
#DISPLAY=:0 eclipse &
git config --global user.email "chantzish@gmail.com"
git config --global user.name "chantzish"
git config --global credential.helper store
printf "%s\n" "$GIT_CREDENTIALS" > .git-credentials
