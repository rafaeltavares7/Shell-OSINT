#!/bin/bash
echo "+---------------------------+"
echo "| instagram: @rafael_cyber1 |"
echo "|---------------------------|"
echo "|------enumdir.sh V.1.0-----|"
echo "+---------------------------+"
# Usando xargs para rodar até 3 processos simultaneamente
cat wordlists/dir.txt | xargs -n 1 -P 3 -I {} bash -c '
# --spider faz com que o wget apenas faça uma "varredura" para verificar diretórios.
# --timeout= define o tempo máximo total de espera
   wget --timeout=5 --spider $1{} 2>&1 | grep "following"
   sleep $(( RANDOM % 5 + 1)) # pausa aleatoria de 1 a 5 segundos
' bash "$1"
# bash $1 no final do comando é usado para passar o argumento $1
# bash -c '...': Para executar os comandos dentro de um subshell.
