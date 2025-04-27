#!/bin/bash

echo -e "\nInstalando..."
apt update -y
apt upgrade -y
apt install jq -y
apt install ffmpeg -y
apt install python3 -y
apt install python3-venv -y
python3 -m venv venv
source venv/bin/activate
pip install yt-dlp
deactivate
echo -e "\nTudo Pronto ;-)\n"
