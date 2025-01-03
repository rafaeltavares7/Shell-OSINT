#!/bin/bash

echo "Instalando..."
apt install whois -y
apt install exiftool -y
apt install openssl -y
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
pip install googlesearch-python

echo "Tudo Pronto ;-)"
echo -e "Desative o ambiente virtual com o seguinte comando: deactivate \n"
