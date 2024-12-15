#!/bin/bash
echo "+---------------------------+"
echo "| instagram: @rafael_cyber1 |"
echo "|---------------------------|"
echo "|------enumdir.sh V.1.0-----|"
echo "+---------------------------+"
echo "enumdir.sh <alvo> <wordlist> <processos paralelos>"
wordlist=$2
paralelo=$3
cat $wordlist | xargs -P $paralelo -I {} bash -c '
# --spider faz com que o wget apenas faça uma "varredura" para verificar diretórios.
# --timeout= define o tempo máximo total de espera
   wget --timeout=3 --tries=1 --spider --limit-rate=1K $1{} 2>&1 | grep "following"
   sleep $(( RANDOM % 5 + 1)) # pausa aleatoria de 1 a 5 segundos
' bash "$1"
# bash $1 no final do comando é usado para passar o argumento $1
# bash -c '...': Para executar os comandos dentro de um subshell.
