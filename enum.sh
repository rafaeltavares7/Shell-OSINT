#!/bin/bash

echo ""
echo "                  _________-----_____ "
echo "       _____------           __      ----_"
echo "___----             ___------              \ "
echo "   ----________        ----                 \ "
echo "               -----__    |             _____)"
echo "                    __-                /     \ "
echo "        _______-----    ___--          \    /)\ "
echo "  ------_______      ---____            \__/  / "
echo "               -----__    \ --    _          /\ "
echo "                      --__--__     \_____/   \_/\ "
echo " --------------------------- ----|   /          |"
echo " |instagram: @rafael_cyber1|     |  |___________|"
echo " ---------------------------     |  | ((_(_)| )_)"
echo "                                 |  \_((_(_)|/(_)"
echo "                                  \             ("
echo "                                   \enum.sh V.1.0)"



alvo=$2
wordlist=$3

if [ "$1" == "-dir" ]; then
  for dir in $(cat $wordlist); do
     # --spider faz com que o wget apenas faça uma "varredura" para verificar diretórios.
     # --timeout= define o tempo máximo total de espera
     result=$(wget --timeout=2 --tries=1 --spider --limit-rate=1K "$alvo$dir" 2>&1 | grep "following" | sed 's/\[[^]]*\]//g' | sed 's/Location://')
     if [ -n "$result" ]; then
       echo -e "\033[0;32m[DIR] $result\033[0m"
     fi
  done

elif [ "$1" == "-sdir" ]; then
  for sdir in $(cat $wordlist); do
     # cat vai ler a wordlist que esta na pasta wordlists
     result=$(host "$sdir.$alvo" | grep "has address" | sed 's/ has address.*//' | uniq)
     if [ -n "$result" ]; then
       echo -e "\033[0;32m[SDIR] $result\033[0m"
     fi
  done

elif [ "$1" == "-h" ]; then
  echo -e "\nEnumerar diretorio: enum.sh -dir URL wordlist"
  echo -e "Enumerar subdominio: enum.sh -sdir dominio.com wordlist\n"
fi
