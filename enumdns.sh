#!/bin/bash
echo "+---------------------------+"
echo "| instagram: @rafael_cyber1 |"
echo "|---------------------------|"
echo "|------enumdns.sh V.1.1-----|"
echo "+---------------------------+"
echo "enumdns.sh <alvo> <wordlist>"

d=$1
wordlist=$2
for s in $(cat $wordlist);
# cat vai ler a wordlist que esta na pasta wordlists
do host $s.$d |grep "has address"

done
