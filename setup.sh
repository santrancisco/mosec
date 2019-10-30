#!/bin/bash

HOMEDIR=/home/vagrant

# Updates
sudo update-locale LANG=en_US.UTF-8 LANGUAGE=en.UTF-8
sudo add-apt-repository ppa:cwchien/gradle -y

# A special session for F*&*#&$*& Java 

# And the rest of the packages
sudo apt-get update

sudo apt-get -y install default-jdk
sudo apt-get install -y linux-headers-$(uname -r) build-essential dkms
sudo apt-get -y install silversearcher-ag 
sudo apt-get -y install git
sudo apt-get -y install vim
sudo apt-get -y install python-pip
sudo apt-get -y install gdb gdb-multiarch
sudo apt-get -y install virtualenv
sudo apt-get -y install android-tools-adb android-tools-fastboot
sudo apt-get -y install wget unzip
sudo apt-get -y install gradle
sudo apt-get -y install service_identity
sudo apt-get -y install libncurses5-dev
sudo apt-get install libxml2-dev libxslt1-dev # to install needle reqs
 

cd $HOMEDIR
mkdir $HOMEDIR/tools
mkdir $HOMEDIR/tools/android
mkdir $HOMEDIR/tools/ios
mkdir $HOMEDIR/tools/misc

sudo pip install pyopenssl
sudo pip install drozer
sudo pip install frida
sudo pip install readline twisted paramiko sshtunnel  biplist # Some prerequisites

## OPTIONAL:
# sudo pip install mitmproxy

cd $HOMEDIR/tools/android
git clone --depth 1 https://github.com/skylot/jadx 
cd jadx
./gradlew dist

cd $HOMEDIR/tools/android
wget https://github.com/mwrlabs/drozer/releases/download/2.3.4/drozer-agent-2.3.4.apk
git clone --depth 1 https://github.com/linkedin/qark/
git clone --depth 1 https://github.com/AndroBugs/AndroBugs_Framework
git clone --depth 1 https://github.com/pxb1988/dex2jar

cd $HOMEDIR/tools/android
git clone --depth 1 git://github.com/iBotPeaches/Apktool.git
#cd Apktool
#./gradle build shadowJar

cd $HOMEDIR/tools/ios
git clone --depth 1 https://github.com/mwrlabs/needle
wget http://www.newosxbook.com/tools/jtool.tar

cd $HOMEDIR/tools/misc
git clone --depth 1 https://github.com/radare/radare2
cd radare2
./sys/install.sh

cd $HOMEDIR/tool/android/qark 
pip install -r requirements.txt
pip install .


## just wrapping apktool to make it friendly
wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -O /usr/bin/apktool
wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.4.0.jar -O /usr/bin/apktool.jar
chmod +x /usr/bin/apktool
chmod +x /usr/bin/apktool.jar


chown -R vagrant:vagrant $HOMEDIR/tools
chown -R vagrant:vagrant $HOMEDIR/tools


######### Getting Hostapd and iptables ###########
## REMEMBER to reboot after installing broadcom driver
sudo apt-get -y install hostapd
sudo apt-get -y install firmware-b43-installer
sudo apt-get -y install udhcpd
sudo apt-get -y install  rng-tools
sudo rngd -r /dev/urandom -o /dev/random

## Download grimd for dns fun stuff
sudo wget https://github.com/looterz/grimd/releases/download/v1.0.6/grimd_linux_x64 -O /usr/local/bin/grimd
sudo chmod +x /usr/local/bin/grimd



echo "Modifying .bashrc to your liking"
read -r -d '' VAR <<EOF
echo -e '\n-------------------------------------
  __  __
 |  \/  | ___  ___  ___  ___
 | |\/| |/ _ \/ __|/ _ \/ __|
 | |  | | (_) \__ \  __/ (__
 |_|  |_|\___/|___/\___|\___|
More information about phone testing:
https://github.com/OWASP/owasp-mstg
https://github.com/OWASP/owasp-masvs

To change proxy setting on android through adb:
adb shell settings put global http_proxy <address>:<port>'

alias cgrep='/bin/grep --color=always'
alias cag='/usr/bin/ag --color'
alias cless='/usr/bin/less -r'
function adbs() {
    adb shell "su -c '$@'"
}

function adbp() {
        adbs ls /data/app/ | grep $1 | xargs -I {} bash -c 'adb pull "/data/app/{}/base.apk"; mv base.apk $(echo {}|cut -d "-" -f 1).apk; apktool d $(echo {}|cut -d "-" -f 1).apk'
}

echo "adbs <command> will execute single command under su privilege over adb. You will need to grant su permission to shell."
echo "adbp <appname> will try to pull application apk, use apktool to uncompress it."
EOF

echo "$VAR" >> /home/vagrant/.bashrc

sudo bash -c "echo 'iface wlxe8de271a66ea inet static
  address 192.168.111.1
  netmask 255.255.255.0' >/etc/network/interfaces.d/10-wlxe8de271a66ea.cfg"


echo "REBOOT now to finish broadcom driver installation"
sudo reboot
