#!/bin/bash

echo "Instalando..."
apt update -y
apt upgrade -y
apt install whois -y
apt install jq -y

echo "Tudo Pronto ;-)"
