#!/bin/bash
echo "+---------------------------+"
echo "| instagram: @rafael_cyber1 |"
echo "|---------------------------|"
echo "|----reverse_dns.sh V.1.0---|"
echo "+---------------------------+"
for ip in $(seq 1 255); # seq sinaliza uma sequencia de 1 a 255
do

  host $1.$ip 2>&1 | grep -i "domain name pointer"
  sleep 2 # adciona 2 de espera.

done

