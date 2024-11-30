#!/bin/bash
echo "+---------------------------+"
echo "| instagram: @rafael_cyber1 |"
echo "|---------------------------|"
echo "|------enumdns.sh V.1.0-----|"
echo "+---------------------------+"
for url in $(cat wordlists/dns.txt);
# cat vai ler a wordlist que esta na pasta wordlists
do host $url.$1 |grep "has address"

done
