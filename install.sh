#!/bin/bash

echo "Instalando..."
apt update -y
apt upgrade -y
apt install whois -y
apt install jq -y
apt install exiftool -y

echo "Tudo Pronto ;-)"
