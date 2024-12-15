#!/bin/bash
echo "+---------------------------+"
echo "| instagram: @rafael_cyber1 |"
echo "|---------------------------|"
echo "|------enumdns.sh V.1.1-----|"
echo "+---------------------------+"
echo "enumdns.sh <alvo> <wordlist>"

wordlist=$2
for url in $(cat $wordlist);
# cat vai ler a wordlist que esta na pasta wordlists
do host $url.$1 |grep "has address"

done
