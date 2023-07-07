#!/bin/bash
MY_FAVORITE_PASS=$2
EMAIL_TO_SEND=$1
sudo apt update && sudo apt install docker docker-compose ssmtp mutt zip -y 
wget https://raw.githubusercontent.com/noaldocruz/war/main/ssmtp.conf
sed -i "s/MY_FAVORITE_PASS/$MY_FAVORITE_PASS/" ssmtp.conf
sudo mv ssmtp.conf /etc/ssmtp/ssmtp.conf
SERVER_URL=$(curl ifconfig.me)
wget https://raw.githubusercontent.com/noaldocruz/war/main/wireguard.yaml
sed -i "s/SERVER_URL_REPLACE/$SERVER_URL/" wireguard.yaml
mv wireguard.yaml docker-compose.yaml
sudo docker-compose up -d 
sudo zip -r config.zip /root/wireguard/peer1
echo "beibiiii" | mutt -a "config.zip" -s "config" -e 'my_hdr From: sender@parachicas.top' -- $EMAIL_TO_SEND
