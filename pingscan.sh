#!/bin/bash
echo "+---------------------------+"
echo "| Instagram: @rafael_cyber1 |"
echo "|---------------------------|"
echo "|-----pingscan.sh V.1.0-----|"
echo "+---------------------------+"
for ip in $(seq 1 254);
do

ping -c 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
sleep 1
# cut -d " " -f 4: cut seleciona o 4º campo
# tr -d ":": Remove os dois pontos (:) da string
# & no final significa que cada ping será executado em segundo plano
done
