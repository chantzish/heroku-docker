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
eclipse -noSplash -application org.eclipse.equinox.p2.director -repository 'jar:file:/home/user/ADT-0.9.4.zip!/,http://download.eclipse.org/releases/galileo,http://download.eclipse.org/eclipse/updates/3.5' -installIU 'com.android.ide.eclipse.adt.feature.group,com.android.ide.eclipse.ddms.feature.group'
DISPLAY=:0 eclipse &
DISPLAY=:0 lxterminal &
xauth generate :0 . trusted
mkdir .vnc
x11vnc -storepasswd $VNC_PASS /home/user/.vnc/passwd
DISPLAY=:0 x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth ~/.vnc/passwd -rfbport 5900 -shared &
printf "%s\n" "$HEROKU_LOGIN" > .netrc
printf "%s\n" "$IDENTITY" > .ssh/id_rsa
yes "" | /opt/android-sdk/tools/android create avd -t android-5 -c 512M -n testy
DISPLAY=:0 /opt/android-sdk/tools/emulator -avd testy &
sleep 20s
DISPLAY=:0 xdotool search Problem windowfocus key Tab
sleep 3s
DISPLAY=:0 xdotool search Problem windowfocus key KP_Enter
sleep 3s
DISPLAY=:0 xdotool search Java windowfocus key F5
#DISPLAY=:0 xdotool search Problem windowclose
#DISPLAY=:0 xdotool search Java windowclose
#pkill eclipse
#DISPLAY=:0 eclipse &
