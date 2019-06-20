FROM i386/ubuntu
RUN apt update && apt install -y sudo && useradd -u 1000 -U -G adm,cdrom,sudo,dip,plugdev -m user && yes "1234" | passwd user
USER user
WORKDIR /home/user
ENV LANG=en_IL
COPY x11vnc_0.9.16-0_i386.deb /home/user/x11vnc_0.9.16-0_i386.deb
RUN echo 1234 | sudo -S apt update && sudo apt install -y whiptail apt-utils libterm-readline-gnu-perl locales && sudo locale-gen en_IL en_US.UTF-8 && sudo update-locale LANG=en_IL && \
    sudo dpkg-reconfigure --frontend=noninteractive locales && sudo DEBIAN_FRONTEND=noninteractive apt install -y keyboard-configuration tzdata && \
    echo '# KEYBOARD CONFIGURATION FILE\n\n# Consult the keyboard(5) manual page.\n\nXKBMODEL="pc105"\nXKBLAYOUT="us,il"\nXKBVARIANT=","\nXKBOPTIONS="grp:alt_shift_toggle,grp_led:scroll"\n\nBACKSPACE="guess"' | sudo tee /etc/default/keyboard && \
    sudo dpkg-reconfigure --frontend=noninteractive keyboard-configuration && sudo dpkg --add-architecture i386 && sudo apt update && \
    sudo apt install -y libc6:i386 libstdc++6:i386 libssl1.0.0:i386 libx11-6:i386 libncurses5:i386 zlib1g:i386 libgtk2.0-0:i386 libsdl1.2debian:i386 libgtk-3-0:i386 && sudo apt install -y curl binutils build-essential vim-tiny net-tools git gawk telnet python python-numpy nginx xserver-xorg-video-dummy \
    x11vnc less socat vde2 qemu zip unzip openssh-server p7zip-rar p7zip-full x11-xserver-utils xdotool x11-apps x11-utils gettext-base firefox vlc leafpad file-roller transmission vlc evince lubuntu-core golang-go binutils-arm-linux-gnueabi gcc-arm-linux-gnueabi openjdk-8-jdk cgroup-tools && \
    sudo sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
    mkdir .ssh && \
    echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCpQbtDyDDhGwUDexAttZlT+pw4vnqcQeLAyg+f8Rzf9mhO2lD1/OcTakj6o1x7RpB+kWU3v0b8Z+RggJYJl02T9kDw9T9bw33Oj80d6mGFqgK3CyAAHRfda6VAQC220LbhgiOfUuTByHrEDGGpSwEF8pcIP9/W5Cm3x4ygiUhEw5vTm0VeywS+PS5338pWA8c6RQXlzVLLqSg6VSpjy0pHn8v65Fait6boRIj94UmizBEbavG255YztKlBh8WpSoCjoyMuz987rNKpqplerlqPzVxStKzkZ3eZwGf49k0H+/6z5w086DBJMFx360IIKzLZ5LD1yEhbKrEDRrIycKOV' > .ssh/authorized_keys && \
    chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys && sudo git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    sudo git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
    sudo apt install -y /home/user/x11vnc_0.9.16-0_i386.deb && \
    mkdir /home/user/.vnc && \
    x11vnc -storepasswd frimon /home/user/.vnc/passwd && \
    sudo sed -i 's/${WEBSOCKIFY} ${SSLONLY} --web ${WEB} ${CERT:+--cert ${CERT}} ${PORT} ${VNC_DEST} ${RECORD_ARG}/${WEBSOCKIFY} ${SSLONLY} --heartbeat=45 --web ${WEB} ${CERT:+--cert ${CERT}} ${PORT} ${VNC_DEST} ${RECORD_ARG}/' /opt/noVNC/utils/launch.sh && \
    echo '#!/bin/sh\n\nwhile :; do wget fccnp4.herokuapp.com -q -O /dev/null -o /dev/null; sleep 4m; done &' | sudo tee /usr/local/sbin/stop.sh && sudo chmod +x /usr/local/sbin/stop.sh && \
    sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && echo export LANG=en_IL >> .profile && echo export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/ >> .profile && \
    sudo rm /etc/xdg/autostart/update-notifier.desktop && sudo sed -i 's/assistive_technologies=org.GNOME.Accessibility.AtkWrapper/#assistive_technologies=org.GNOME.Accessibility.AtkWrapper/' /etc/java-8-openjdk/accessibility.properties
    #wget https://dl.google.com/android/ADT-23.0.7.zip
    #wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && tar zxvf android-sdk_r24.4.1-linux.tgz
    #wget http://dl.google.com/android/repository/support_r23.1.1.zip && unzip support_r23.1.1.zip -d android-sdks/extras/android/
    #wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && sudo unzip sdk-tools-linux-4333796.zip -d /opt/android-sdk && \
    #yes | sudo JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/ /opt/android-sdk/tools/bin/sdkmanager --install "emulator" "build-tools;28.0.3" "platforms;android-28" "platform-tools" "tools" "patcher;v4" "sources;android-28" "platforms;android-10" ##"system-images;android-10;default;x86" "system-images;android-19;default;x86"
COPY heroku.yml /home/user/heroku.yml
COPY xorg.conf /home/user/xorg.conf
COPY nginx.template /home/user/nginx.template
COPY launch.sh /home/user/launch.sh
COPY launch-gui.sh /home/user/launch-gui.sh
COPY Dockerfile /home/user/Dockerfile
CMD /home/user/launch-gui.sh & /home/user/launch.sh 

