#!/bin/bash
echo "+---------------------------+"
echo "| instagram: @rafael_cyber1 |"
echo "|---------------------------|"
echo "|------scanner.sh V.1.0-----|"
echo "+---------------------------+"
service tor start
# Usando xargs para rodar até 3 processos simultaneamente
cat wordlists/top_portas.txt | xargs -P 7 -I {} bash -c '
# Com o -I {} o xargs passa cada linha como argumento pro comando bash -c
  proxychains4 nc -zv -w 2 $1 {} 2>&1 | grep -i "open" # -w especifica o tempo limite
  sleep $(( RANDOM % 3 + 1)) # pausa aleatória de 1 a 3 segundos
' bash "$1"
# bash $1 no final do comando é usado para passar o argumento $1
# bash -c '...': Para executar os comandos dentro de um subshell
