#!/bin/bash
# Kali setup

#Fix Network Manager
sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf
sleep 2

#Fix repositories
echo "Fixing repos"
sleep 1
echo '##Rolling' > /etc/apt/sources.list
echo 'deb http://http.kali.org/kali kali-rolling main contrib non-free' >> /etc/apt/sources.list
echo 'deb-src http://http.kali.org/kali kali-rolling main contrib non-free' >> /etc/apt/sources.list
echo /etc/init.d/networking restart
clear

#update files
echo "Updating Kali"
sleep 1
apt-get update && apt-get upgrade && apt-get dist-upgrade -y
sleep 5
clear

#sound on virtualbox sharing and screen
echo "Fixing virtualbox sharing and screen"
sleep 1
apt-get install virtualbox-guest-x11 -y

#sound on boot
echo "Fixing sound on boot"
sleep 1
apt-get install alsa-utils -y

#install software center
echo "Setting up Software center"
sleep 1
apt-get install software-center -y

#install archive manager
echo "Setting up archive manager tools"
sleep 1
apt-get install unrar unace rar unrar p7zip zip unzip p7zip-full p7zip-rar file-roller -y

#Install Filezilla FTP Client
echo "Setting up Ftp Client"
sleep 1
apt-get install filezilla filezilla-common -y

#Install HTOP and NetHogs
echo "Setting up HTOP and NetHogs"
sleep 1
apt-get install htop nethogs -y

#Install GDebi Package Manager
echo "Setting up package installer"
sleep 1
apt-get install gdebi -y

#Install Persistent-IP-tables
echo "Setting up Persistent-IP-tables"
sleep 1
apt-get install iptables-persistent -y

#Install PMKID attack dependencies
sudo apt install libcurl4-openssl-dev libpcap0.8-dev zlib1g-dev libssl-dev
sudo git clone https://github.com/ZerBea/hcxdumptool.git
sudo git clone https://github.com/ZerBea/hcxtools.git
sudo git clone https://github.com/hashcat/hashcat.git

#Install Tools
cd hcxdumptool/
sudo make
sudo make install
cd ..
cd hcxtools/
sudo make
sudo make install
cd ..
cd hashcat/
sudo make
sudo make install
cd ..

#Install wifi drivers for AC1900
echo "Do you want to install AC1900 drivers? "
read -p "yes or no: " driver
case "$driver" in 
  y|Y|yes ) echo "yes"; apt-get install dkms; apt-get install bc; apt-get install build-essential; apt-get install linux-headers-$(uname -r); sudo git clone https://github.com/aircrack-ng/rtl8812au.git; cd rtl8812au/; sudo bash dkms-install.sh; cd ..; return;; 
  n|N|no ) echo "no";;
  * ) echo "Quitting script."; exit;;
esac

#change root password
echo "Do you want to change root password? "
read -p "yes or no: " choice
case "$choice" in 
  y|Y|yes ) echo "yes"; passwd; return;; 
  n|N|no ) echo "no";;
  * ) echo "Quitting script."; exit;;
esac

#cleanup
echo "Do you want to cleanup?"
read -p "yes or no: " cleanup
case "$cleanup" in 
  y|Y|yes ) echo "yes"; apt-get autoremove -y; apt-get clean;;
  n|N|no ) echo "no"; exit;;
  * ) echo "Quitting script."; exit;;
esac
