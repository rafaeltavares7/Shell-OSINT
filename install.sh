#!/bin/bash

echo "Instalando..."
apt update -y
apt upgrade -y
apt install jq -y
apt install proxychains -y
apt install tor -y

echo "Tudo Pronto ;-)"
