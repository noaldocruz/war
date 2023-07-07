#!/bin/bash
sudo apt update && sudo apt install docker docker-compose && sudo apt install mailutils  && sudo apt-get install ssmtp && sudo apt  install mutt && sudo apt install unzip && sudo apt install zip -y 
wget https://raw.githubusercontent.com/noaldocruz/war/main/ssmtp.conf
sed -i "s/MY_FAVORITE_PASS/$2/" ssmtp.conf
sudo mv ssmtp.conf /etc/ssmtp/ssmtp.conf
SERVER_URL=$(curl ifconfig.me)
wget https://raw.githubusercontent.com/noaldocruz/war/main/wireguard.yaml
sed -i "s/SERVER_URL_REPLACE/$SERVER_URL/" wireguard.yaml
mv wireguard.yaml docker-compose.yaml
sudo docker-compose up -d 
sudo zip -r config.zip /root/wireguard/peer1
echo "beibiiii" | mutt -a "config.zip" -s "config" -e 'my_hdr From: sender@parachicas.top' -- $1
