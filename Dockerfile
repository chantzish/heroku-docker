FROM i386/ubuntu
RUN apt update && apt install -y sudo && useradd -u 1000 -U -G adm,cdrom,sudo,dip,plugdev -m user && yes "1234" | passwd user
USER user
WORKDIR /home/user
ENV LANG=en_IL
COPY x11vnc_0.9.16-0_i386.deb /home/user/x11vnc_0.9.16-0_i386.deb
COPY jdk-6u45-linux-i586.bin /home/user/jdk-6u45-linux-i586.bin
COPY system.img /home/user/system.img
RUN echo 1234 | sudo -S apt update && \
    sudo apt install -y whiptail apt-utils libterm-readline-gnu-perl locales apt-transport-https curl gnupg && \
    echo "deb https://cli-assets.heroku.com/apt ./" | sudo tee /etc/apt/sources.list.d/heroku.list && \
    curl https://cli-assets.heroku.com/apt/release.key | sudo apt-key add - && \
    sudo locale-gen en_IL en_US.UTF-8 && \
    sudo update-locale LANG=en_IL && \
    sudo dpkg-reconfigure --frontend=noninteractive locales && \
    sudo DEBIAN_FRONTEND=noninteractive apt install -y keyboard-configuration tzdata && \
    echo '# KEYBOARD CONFIGURATION FILE\n\n# Consult the keyboard(5) manual page.\n\nXKBMODEL="pc105"\nXKBLAYOUT="us,il"\nXKBVARIANT=","\nXKBOPTIONS="grp:alt_shift_toggle,grp_led:scroll"\n\nBACKSPACE="guess"' | sudo tee /etc/default/keyboard && \
    sudo dpkg-reconfigure --frontend=noninteractive keyboard-configuration && \
    sudo dpkg --add-architecture amd64 && \
    sudo apt update && \
    sudo apt install -y \
        libc6:amd64 \
        libstdc++6:amd64 \
        libssl1.0.0:amd64 \
        libx11-6:amd64 \
        libncurses5:amd64 \
        zlib1g:amd64 \
        libgtk2.0-0:amd64 \
        libsdl1.2debian:amd64 \
        libgtk-3-0:amd64 \
        nodejs:amd64 \
        heroku:amd64 \
        bzip2 libbz2-1.0 libbz2-1.0:amd64 libdb5.3:amd64 libexpat1:amd64 libffi6:amd64 libgpm2:amd64 libncursesw5:amd64 libpython-stdlib:amd64 libpython2.7-minimal:amd64 libpython2.7-stdlib:amd64 && \
    sudo apt install -y \
        curl \
        binutils \
        build-essential \
        vim-tiny \
        net-tools \
        git \
        gawk \
        telnet \
        python \
        python-numpy \
        nginx \
        xserver-xorg-video-dummy \
        x11vnc \
        less \
        socat \
        vde2 \
        qemu \
        zip \
        unzip \
        openssh-server \
        p7zip-rar \
        p7zip-full \
        x11-xserver-utils \
        xdotool \
        x11-apps \
        x11-utils \
        gettext-base \
        firefox \
        vlc \
        leafpad \
        file-roller \
        transmission \
        evince \
        lubuntu-core \
        golang-go \
        binutils-arm-linux-gnueabi \
        gcc-arm-linux-gnueabi \
        #openjdk-8-jdk \
        cgroup-tools && \
    sudo sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
    mkdir .ssh && \
    echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCpQbtDyDDhGwUDexAttZlT+pw4vnqcQeLAyg+f8Rzf9mhO2lD1/OcTakj6o1x7RpB+kWU3v0b8Z+RggJYJl02T9kDw9T9bw33Oj80d6mGFqgK3CyAAHRfda6VAQC220LbhgiOfUuTByHrEDGGpSwEF8pcIP9/W5Cm3x4ygiUhEw5vTm0VeywS+PS5338pWA8c6RQXlzVLLqSg6VSpjy0pHn8v65Fait6boRIj94UmizBEbavG255YztKlBh8WpSoCjoyMuz987rNKpqplerlqPzVxStKzkZ3eZwGf49k0H+/6z5w086DBJMFx360IIKzLZ5LD1yEhbKrEDRrIycKOV' > .ssh/authorized_keys && \
    chmod 700 ~/.ssh && \
    chmod 600 ~/.ssh/authorized_keys && \
    sudo git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    sudo git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
    sudo apt install -y /home/user/x11vnc_0.9.16-0_i386.deb && \
    sudo sed -i 's/${WEBSOCKIFY} ${SSLONLY} --web ${WEB}/${WEBSOCKIFY} ${SSLONLY} --heartbeat=45 --web ${WEB}/' /opt/noVNC/utils/launch.sh && \
    echo '#!/bin/sh\n\nwhile :; do wget fccnp6.herokuapp.com -q -O /dev/null -o /dev/null; sleep 4m; done &' | sudo tee /usr/local/sbin/stop.sh && \
    sudo chmod +x /usr/local/sbin/stop.sh && \
    sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
    sudo chmod +x jdk-6u45-linux-i586.bin && \
    ./jdk-6u45-linux-i586.bin && \
    sudo mv jdk1.6.0_45 /opt/ && \
    echo export LANG=en_IL >> .profile && \
    echo export JAVA_HOME=/opt/jdk1.6.0_45/ >> .profile && \
    echo 'appletviewer\nextcheck\nidlj\njar\njarsigner\njavac\njavadoc\njavah\njavap\njcmd\njconsole\njdb\njdeps\njhat\njinfo\njmap\njps\njrunscript\njsadebugd\njstack\njstat\njstatd\nnative2ascii\nrmic\nschemagen\nserialver\nwsgen\nwsimport\nxjc' | while read -r line; do if [ -f /opt/jdk1.6.0_45/bin/$line ]; then echo 1234 | sudo -S update-alternatives --install /usr/bin/$line $line /opt/jdk1.6.0_45/bin/$line 1; fi; done && \ 
    echo 'clhsdb\nhsdb\njava\njjs\nkeytool\norbd\npack200\npolicytool\nrmid\nrmiregistry\nservertool\ntnameserv\nunpack200\njexec' | while read -r line; do if [ -f /opt/jdk1.6.0_45/jre/bin/$line ]; then echo 1234 | sudo -S update-alternatives --install /usr/bin/$line $line /opt/jdk1.6.0_45/jre/bin/$line 1; fi; done && \ 
    echo 1234 | sudo -S rm /etc/xdg/autostart/update-notifier.desktop && \
    #sudo sed -i 's/assistive_technologies=org.GNOME.Accessibility.AtkWrapper/#assistive_technologies=org.GNOME.Accessibility.AtkWrapper/' /etc/java-8-openjdk/accessibility.properties
    wget https://archive.eclipse.org/eclipse/downloads/drops/R-3.5-200906111540/eclipse-SDK-3.5-linux-gtk.tar.gz && \
    sudo tar zxvf eclipse-SDK-3.5-linux-gtk.tar.gz -C /opt && \
    sudo ln -s /opt/eclipse/eclipse /usr/local/sbin/eclipse && \
    wget http://dl.google.com/android/ADT-0.9.4.zip && \
    sudo eclipse -noSplash -application org.eclipse.equinox.p2.director -repository 'jar:file:/home/user/ADT-0.9.4.zip!/,http://download.eclipse.org/releases/galileo' -installIU com.android.ide.eclipse.adt.feature.group && \
    sudo eclipse -noSplash -application org.eclipse.equinox.p2.director -repository 'jar:file:/home/user/ADT-0.9.4.zip!/,http://download.eclipse.org/releases/galileo' -installIU com.android.ide.eclipse.ddms.feature.group && \
    sudo mkdir /opt/eclipse/configuration/.settings/ && \
    echo SHOW_WORKSPACE_SELECTION_DIALOG=false | sudo tee /opt/eclipse/configuration/.settings/org.eclipse.ui.ide.prefs && \
    #git clone https://github.com/chantzish/learn-android.git && \
    #mv learn-android workspace && \
    mkdir .android && \
    echo pingId=1381121918004102010>.android/ddms.cfg && \
    wget http://dl-ssl.google.com/android/android-sdk_r3-linux.tgz && \
    sudo tar zxvf android-sdk_r3-linux.tgz -C /opt/ && \
    sudo mv /opt/android-sdk-linux/ /opt/android-sdk/ && \
    wget http://dl-ssl.google.com/android/repository/android-2.0_r01-linux.zip && \
    sudo unzip android-2.0_r01-linux.zip -d /opt/android-sdk/platforms/ &&\
    sudo mv /opt/android-sdk/platforms/android-2.0_r01-linux/ /opt/android-sdk/platforms/android-2.0_r01/ && \
    sudo rm /opt/android-sdk/platforms/android-2.0_r01/images/system.img && \
    sudo cp system.img /opt/android-sdk/platforms/android-2.0_r01/images/ && \
    /opt/android-sdk/tools/adb start-server && \
    sudo sed -i 's/load-module module-udev-detect/#load-module module-udev-detect/' /etc/pulse/default.pa && \
    sudo sed -i 's/load-module module-bluetooth-discover/#load-module module-bluetooth-discover/' /etc/pulse/default.pa && \
    echo KexAlgorithms +diffie-hellman-group1-sha1 | sudo tee -a /etc/ssh/sshd_config && \
    echo "#HostKeyAlgorithms +ssh-dss" | sudo tee -a /etc/ssh/sshd_config && \
    echo "#MACs +hmac-sha1" | sudo tee -a /etc/ssh/sshd_config && \
    echo Ciphers +aes128-cbc | sudo tee -a /etc/ssh/sshd_config && \
    sudo sed -i 's/#Port 22/Port 2200/' /etc/ssh/sshd_config && \
    yes "" | /opt/android-sdk/tools/android list targets && \
    ls /opt/android-sdk/platforms/android-2.0_r01 -a && \
    /opt/android-sdk/tools/adb kill-server && \
    wget https://github.com/novnc/websockify/raw/master/websockify/websocket.py && \
    wget https://github.com/chantzish/python-dewebsockify/raw/master/dewebsockify.py
COPY heroku.yml /home/user/heroku.yml
COPY xorg.conf /home/user/xorg.conf
COPY nginx.template /home/user/nginx.template
COPY launch.sh /home/user/launch.sh
COPY launch-gui.sh /home/user/launch-gui.sh
COPY Dockerfile /home/user/Dockerfile
CMD /home/user/launch-gui.sh & /home/user/launch.sh 

