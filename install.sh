#!/bin/bash

echo "Instalando..."
apt update -y
apt upgrade -y
apt install xxd -y
apt install whois -y
apt install openssl -y
apt install p7zip-full -y
apt install tor -y
apt install proxychains4 -y
apt install jq -y
apt install aircrack-ng -y
apt install gpg -y
apt install netcat-traditional -y
apt install sshpass -y
apt install python3 -y
apt install python3-venv -y
python3 -m venv yt-dlp-env
source yt-dlp-env/bin/activate
pip install yt-dlp

echo "Tudo Pronto ;-)"
echo -e "Desative o ambiente virtual com o seguinte comando: deactivate \n"
