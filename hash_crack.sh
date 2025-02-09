#!/bin/bash

clear
echo ""
echo -e "\033[0;32m#######################################################################################################\033[0m"
echo -e "\033[0;32m# ██╗  ██╗ █████╗ ███████╗██╗  ██╗         ██████╗██████╗  █████╗  ██████╗██╗  ██╗   ███████╗██╗  ██╗ #\033[0m"
echo -e "\033[0;32m# ██║  ██║██╔══██╗██╔════╝██║  ██║        ██╔════╝██╔══██╗██╔══██╗██╔════╝██║ ██╔╝   ██╔════╝██║  ██║ #\033[0m"
echo -e "\033[0;32m# ███████║███████║███████╗███████║        ██║     ██████╔╝███████║██║     █████╔╝    ███████╗███████║ #\033[0m"
echo -e "\033[0;32m# ██╔══██║██╔══██║╚════██║██╔══██║        ██║     ██╔══██╗██╔══██║██║     ██╔═██╗    ╚════██║██╔══██║ #\033[0m"
echo -e "\033[0;32m# ██║  ██║██║  ██║███████║██║  ██║███████╗╚██████╗██║  ██║██║  ██║╚██████╗██║  ██╗██╗███████║██║  ██║ #\033[0m"
echo -e "\033[0;32m# ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝ #\033[0m"
echo -e "\033[0;32m# instagram: @rafael_cyber1 | V 1.2 ###################################################################\033[0m\n"

# Caminho para a wordlist
wordlist=$3

###############MD5

# Verifica se o primeiro argumento fornecido ao script é "-md5"
if [ "$1" == "-md5" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que seria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -md5 | awk '{print $2}')
    
# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"
      
# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"

###############SHA1

# Verifica se o primeiro argumento fornecido ao script é "-sha1"
elif [ "$1" == "-sha1" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que seria gerada
    hashed_word=$(echo -n "$word" | openssl  dgst -sha1 | awk '{print $2}')

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"
###############SHA224

# Verifica se o primeiro argumento fornecido ao script é "-sha224"
elif [ "$1" == "-sha224" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que seria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -sha224 | awk '{print $2}')

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"

###############SHA3-224

# Verifica se o primeiro argumento fornecido ao script é "-sha3-224"
elif [ "$1" == "-sha3-224" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que siria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -sha3-224 | awk '{print $2}')
# o openssl retorna algo como MD4(stdin)= <hash>. O awk '{print $2}' pega o hash gerado.

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"

###############SHA256

# Verifica se o primeiro argumento fornecido ao script é "-sha256"
elif [ "$1" == "-sha256" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que seria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -sha256 | awk '{print $2}')

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"
###############SHA3-256

# Verifica se o primeiro argumento fornecido ao script é "-sha3-256"
elif [ "$1" == "-sha3-256" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que siria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -sha3-256 | awk '{print $2}')
# o openssl retorna algo como MD4(stdin)= <hash>. O awk '{print $2}' pega o hash gerado.

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"

###############SHA384

# Verifica se o primeiro argumento fornecido ao script é "-sha384"
elif [ "$1" == "-sha384" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que seria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -sha384 | awk '{print $2}')

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"
###############SHA3-384

# Verifica se o primeiro argumento fornecido ao script é "-sha3-384"
elif [ "$1" == "-sha3-384" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que siria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -sha3-384 | awk '{print $2}')
# o openssl retorna algo como MD4(stdin)= <hash>. O awk '{print $2}' pega o hash gerado.

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"

###############SHA512

# Verifica se o primeiro argumento fornecido ao script é "-sha512"
elif [ "$1" == "-sha512" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que seria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -sha512 | awk '{print $2}')

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"
###############SHA3-512

# Verifica se o primeiro argumento fornecido ao script é "-sha3-512"
elif [ "$1" == "-sha3-512" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que siria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -sha3-512 | awk '{print $2}')
# o openssl retorna algo como MD4(stdin)= <hash>. O awk '{print $2}' pega o hash gerado.

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"
###############SHA12-224

# Verifica se o primeiro argumento fornecido ao script é "-sha512-224"
elif [ "$1" == "-sha512-224" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que siria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -sha512-224 | awk '{print $2}')
# o openssl retorna algo como MD4(stdin)= <hash>. O awk '{print $2}' pega o hash gerado.

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"
###############SHA512-256

# Verifica se o primeiro argumento fornecido ao script é "-sha512-256"
elif [ "$1" == "-sha512-256" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que siria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -sha512-256 | awk '{print $2}')
# o openssl retorna algo como MD4(stdin)= <hash>. O awk '{print $2}' pega o hash gerado.

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"

###############B2

# Verifica se o primeiro argumento fornecido ao script é "-b2"
elif [ "$1" == "-b2" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que seria gerada
    hashed_word=$(echo -n "$word" | b2sum | awk '{print $1}')

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"
###############RMD160

# Verifica se o primeiro argumento fornecido ao script é "-rmd160"
elif [ "$1" == "-rmd160" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que siria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -rmd160 | awk '{print $2}')
# o openssl retorna algo como MD4(stdin)= <hash>. O awk '{print $2}' pega o hash gerado.

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"

###############SM3

# Verifica se o primeiro argumento fornecido ao script é "-sm3"
elif [ "$1" == "-sm3" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que siria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -sm3 | awk '{print $2}')
# o openssl retorna algo como MD4(stdin)= <hash>. O awk '{print $2}' pega o hash gerado.

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"

###############BLAKE2S256

# Verifica se o primeiro argumento fornecido ao script é "-blake2s256"
elif [ "$1" == "-blake2s256" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que siria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -blake2s256 | awk '{print $2}')
# o openssl retorna algo como MD4(stdin)= <hash>. O awk '{print $2}' pega o hash gerado.

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"

##############BLAKE2B512

# Verifica se o primeiro argumento fornecido ao script é "-blake2b512"
elif [ "$1" == "-blake2b512" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que siria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -blake2b512 | awk '{print $2}')
# o openssl retorna algo como MD4(stdin)= <hash>. O awk '{print $2}' pega o hash gerado.

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"

###############SHAKE128

# Verifica se o primeiro argumento fornecido ao script é "-shake128"
elif [ "$1" == "-shake128" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que siria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -shake128 | awk '{print $2}')
# o openssl retorna algo como MD4(stdin)= <hash>. O awk '{print $2}' pega o hash gerado.

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"

###############SHAKE256

# Verifica se o primeiro argumento fornecido ao script é "-shake256"
elif [ "$1" == "-shake256" ]; then
  # O segundo argumento é o hash que queremos tentar quebrar
  hash=$2

# Cada linha será comparada com o hash fornecido
  while IFS= read -r word; do # Inicia o loop
# echo -n remove a quebra de linha do final da palavra
# O awk '{print $1}' pega apenas o hash, descartando a parte do nome do arquivo que siria gerada
    hashed_word=$(echo -n "$word" | openssl dgst -shake256 | awk '{print $2}')
# o openssl retorna algo como MD4(stdin)= <hash>. O awk '{print $2}' pega o hash gerado.

# Compara o hash gerado com o hash fornecido
    if [ "$hashed_word" == "$hash" ]; then
# Imprime a senha que corresponde ao hash fornecido
      echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"

# Sai do loop, pois já encontramos a senha
      break
    fi
  done < "$wordlist"

###############GPG

# Verifica se o primeiro argumento fornecido ao script é "-gpg"
elif [ "$1" == "-gpg" ]; then
    # Tentativa de descriptografar o arquivo com cada senha do wordlist
    hash=$2
    while IFS= read -r word; do # inicia o loop
        # Tenta descriptografar usando a senha do wordlist
        echo "$word" | gpg --batch --yes --passphrase-fd 0 -d "$hash" > /dev/null 2>&1 # Qualquer coisa que for enviada para /dev/null é simplesmente descartada
        # Verifica se a descriptografia foi bem-sucedida
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"
            break
        fi
    done < "$wordlist"

# --batch desativa interações manuais
# --yes aceita automaticamente todas as perguntas do GPG
# --passphrase-fd 0 especifica de onde o GPG deve ler a senha
# -d instrui o GPG descriptografar o arquivo

###############ZIP

elif [ "$1" == "-zip" ]; then
  hash=$2
  while IFS= read -r word; do # inicia o loop
      saida=$(7z x "$hash" -p"$word" -y 2>&1)  # Tenta extrair com a senha usando 7z
      if echo "$saida" | grep -q "Everything is Ok"; then  # Verifica se a extração foi bem-sucedida
        echo -e "\033[0;32m[+] Cracked Hash: $word\033[0m\n"
        break
      fi
  done < "$wordlist"

###############BASE64

elif [ "$1" == "-base64" ]; then
  hash=$2
  base=$(echo "$hash" | base64 --decode)
  if [ -n "$base" ]; then
    echo -e "\033[0;32m[+] Cracked Hash: $base\033[0m\n"
  fi

###############EXADECIMAL

elif [ "$1" == "-hexadecimal" ]; then
  hash=$2
  hex=$(echo "$hash" | xxd -r -p) # usando o xxd pra operação reversa
  if [ -n "$hex" ]; then
    echo -e "\033[0;32m[+] Cracked Hash: $hex\033[0m\n"
  fi

###############HELP

elif [ "$1" == "-h" ]; then
  echo -e "\033[0;32m+------------------------------------------------------------+\033[0m"
  echo -e "\033[0;32m| hash_crack.sh: [Argument] [Hash here] [Wordlist]:          |\033[0m"
  echo -e "\033[0;32m| -md5, -sha1, -sha224, -sha3-224, -sha256, -sha3-256        |\033[0m"
  echo -e "\033[0;32m| -sha384, -sha3-384, -sha512, -sha3-512 -sha512-256, -b2    |\033[0m"
  echo -e "\033[0;32m| -sha512-224, -blake2s256, -blake2b512, -rmd160, -sm3       |\033[0m"
  echo -e "\033[0;32m| -shake128, -shake256, -gpg, -zip, -base64, -hexadecimal    |\033[0m"
  echo -e "\033[0;32m+------------------------------------------------------------+\033[0m\n"
fi
