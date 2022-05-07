#!/bin/bash
cd /root 
sudo apt-get update
sudo apt install unzip
apt-get install -y python3 python3-pip
sudo apt install -y libsodium-dev cmake g++ git build-essential
sudo apt update
mkdir /ssd
mkfs -t ext4 /dev/sdb -y
mount /dev/sdb -t ext4 /ssd
mkfs -t ext4 /dev/sdc -y
mount /dev/sdc -t ext4 /ssd
mkfs -t ext4 /dev/sda -y
mount /dev/sda -t ext4 /ssd
mkdir /ssd1
mkdir /ssd2
git clone https://github.com/madMAx43v3r/chia-plotter.git 
cd chia-plotter
git submodule update --init
./make_devel.sh
curl https://rclone.org/install.sh | sudo bash
cd /root
mkdir .config
cd /root/.config
mkdir rclone
cd /root/.config/rclone
wget https://raw.githubusercontent.com/fatih1086kaya/rclone/main/dropbox.zip
unzip dropbox.zip
chmod 777 kopya.sh
screen -dm -S "tasima" ./kopya.sh
cd /root/chia-plotter/
screen -S "plor" -d -m ./build/chia_plot  -n -1 -r 8 -u 7 -t /ssd1/ -d /ssd2/ -p b2b69db0781eac278b31802ca3073c4ab4096b6af6d8f9fbb124397eb41d8ffb85bd693a40fa7bd602bd95706f2a9069 -f 91612b26f7a980002dc6ba52052ad3875082e04adbcd2ff5cfd9d6ead9992da1c5610feff5f22d79670b9c362ad6bd40 -u 256 -v 256
