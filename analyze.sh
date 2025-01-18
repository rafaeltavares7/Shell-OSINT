#!/bin/bash

d=$2

if [ "$1" == "---download" ]; then

  mkdir -p analyzedownloads && wget -r -np -k -P analyzedownloads --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" $d # Baixar o Site inteiro. -P Especifica que sera salvo no diretório analyzedownloads
  # -r (recursivo): Faz o wget baixe a página inicial e, em seguida, siga os links encontrados
  # -np (no parent): Isso significa que o wget não irá sair da área do site indicado (não seguirá links para fora do domínio).
  # -k (convert): Converte os links internos no arquivo baixado, permitindo que você navegue no site offline.
  # Buscar tudo dentro de (href)

  clear
  echo ""
  echo "                   _                     _       "
  echo "  __ _ _ __   __ _| |_   _ _______   ___| |__    "
  echo " / _  |  _ \ / _  | | | | |_  / _ \ / __|  _ \   "
  echo "| (_| | | | | (_| | | |_| |/ /  __/_\__ \ | | |  "
  echo " \__ _|_| |_|\__ _|_|\__  /___\___(_)___/_| |_|  "
  echo "                      |___/      |               "
  echo "Instagram: rafael_cyber1 | V 1.4 |"
  # Extrair o domínio da URL em $d
  domain=$(echo $d | sed -E 's/^(https?:\/\/)?([^\/]+).*$/\2/')
  domain=$(echo $domain | sed 's/^www\.//') # Para evitar erros ele retira (www) caso tenha.
  echo "Consulta WHOIS: $domain"
  whois $domain | grep -E -i "Tech|admin|name serve" | sed 's/Registry Tech ID:.*//' |  sed 's/Tech Name:.*//' | sed 's/   Name Server:.*//' | sed '/^$/d'
  echo -e "\nIP: $domain"
  host $domain | grep "has" | sed 's/.* //'
  sleep 1

  echo -e "\nEncontrado em (href):"
  grep -r -oP -h 'href="\K[^"]+' analyzedownloads
  sleep 1

  # Buscar tudo dentro de (src)
  echo -e "\nEncontrado em (src):"
  grep -r -oP -h 'src="\K[^"]+' analyzedownloads
  sleep 1

  # Busca por emails
  echo -e "\nEmails:"
  grep -r -oP -h '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}' analyzedownloads
  sleep 1
  # sed remove informações da resposta como informações inuteis ou inrelevantes
  echo -e "\nConsulta Exiftool:"
  exiftool -r analyzedownloads | sed 's/File Size.*//' | sed 's/MIME Type.*//' | sed 's/File Type.*//' | sed 's/Derived From Instance ID.*//' | sed 's/Derived From Document ID.*//' | sed 's/History Instance ID.*//' | sed 's/Derived From Original Document ID.*//' | sed '>
  sleep 1

  echo -e "\nPesquisa com Shodan:"
  result=$(host $domain | grep 'has address' | head -n 1 | sed "s/$domain has address //") # head -n 1 tras apenas o primeiro resultado
  results=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.shodan.io/host/$result" | grep -oP '(?<=Ports open: ).*(?=")') # grep -oP '(?<=Ports open: ).*(?=")') tras tudo depois de Ports open: e antes de "
  echo "[IP] $result [OPEN] $results."
  sleep 1

  echo -e "\nPesquisa com Dorks:" # usa a API do google PSE. Pressisa do KEY e do ID
  json1=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KEY_&cx=_YOUR_ID_&q=site:${domain}")
  echo "$json1" | jq -r '.items[].link'
  sleep 1
  
  json2=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KEY_&cx=_YOUR_ID_&q=site:${domain}&start=11")
  echo "$json2" | jq -r '.items[].link'

  json3=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KAY_&cx=_YOUR_ID_&q=site:${domain}&start21")
  echo "$json2" | jq -r '.items[].link'

  json4=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KEY_&cx=_YOUR_ID_&q=site:${domain}&start=31")
  echo "$json4" | jq -r '.items[].link'

  json5=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KEY_&cx=_YOUR_ID_&q=site:${domain}&start=41")
  echo "$json5" | jq -r '.items[].link'
  sleep 1
  
  echo -e "\nTextos encontrados:"
  echo "$json1" | jq -r '.items[].snippet'
  echo "$json2" | jq -r '.items[].snippet'
  echo "$json3" | jq -r '.items[].snippet'
  echo "$json4" | jq -r '.items[].snippet'
  echo "$json5" | jq -r '.items[].snippet'

  echo -e "\nExtração de informações concluido."
  # -o do grep faz ele imprimir apenas o que corresponde ao padrão.
  # -P ativa o suporte à expressão regular Perl, que usar a sintaxe avançada
  # \K. O \K diz ao grep para "descartar" o que tem antes dessa parte,

elif [ "$1" == "---extrair" ]; then

  clear
  echo ""
  echo "                   _                     _       "
  echo "  __ _ _ __   __ _| |_   _ _______   ___| |__    "
  echo " / _  |  _ \ / _  | | | | |_  / _ \ / __|  _ \   "
  echo "| (_| | | | | (_| | | |_| |/ /  __/_\__ \ | | |  "
  echo " \__ _|_| |_|\__ _|_|\__  /___\___(_)___/_| |_|  "
  echo "                      |___/      |               "
  echo "Instagram: rafael_cyber1 | V 1.4 |"
  echo "---------------------------------+"
  echo ""

  domain=$(echo $d | sed -E 's/^(https?:\/\/)?([^\/]+).*$/\2/')
  domain=$(echo $domain | sed 's/^www\.//') # Para evitar erros ele retira (www) caso tenha.
  echo "Consulta WHOIS: $domain"
  whois $domain | grep -E -i "Tech|admin|name serve" | sed 's/Registry Tech ID:.*//' |  sed '>

  echo -e "\nIP: $domain"
  host $domain | grep "has" | sed 's/.* //'
  sleep 1

  echo -e "\nEncontrado em (href):"
  curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" $d | grep -oP 'href="\K[^"]+'
  sleep 1

  echo -e "\nEncontrado em (src):"
  curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" $d | grep -oP 'src="\K[^"]+'
  sleep 1

  echo -e "\nEmails:"
  curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" $d | grep -oP '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}'
  sleep 1
  
  echo -e "\nPesquisa com Shodan:"
  result=$(host $domain | grep 'has address' | head -n 1 | sed "s/$domain has address //") # head -n 1 tras apenas o primeiro resultado
  results=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.shodan.io/host/$result" | grep -oP '(?<=Ports open: ).*(?=")') # grep -oP '(?<=Ports open: ).*(?=")') tras tudo depois de Ports open: e antes de "
  echo "[IP] $result [OPEN] $results."
  sleep 1
  
  echo -e "\nPesquisa com Dorks:"
  json1=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KEY_&cx=_YOUR_ID_&q=site:${domain}&start=1")
  echo "$json1" | jq -r '.items[].link'

  json2=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KEY_&cx=_YOUR_ID_&q=site:${domain}&start=11")
  echo "$json2" | jq -r '.items[].link'

  json3=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KEY_&cx=_YOUR_ID_&q=site:${domain}&start21")
  echo "$json2" | jq -r '.items[].link'

  json4=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KEY_&cx=_YOUR_ID_&q=site:${domain}&start=31")
  echo "$json4" | jq -r '.items[].link'

  json5=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KEY_&cx=_YOUR_ID_&q=site:${domain}&start=41")
  echo "$json5" | jq -r '.items[].link'
  sleep 1

  echo -e "\nTextos encontrados:"
  echo "$json1" | jq -r '.items[].snippet'
  echo "$json2" | jq -r '.items[].snippet'
  echo "$json3" | jq -r '.items[].snippet'
  echo "$json4" | jq -r '.items[].snippet'
  echo "$json5" | jq -r '.items[].snippet'

  echo -e "\nExtração de informações concluido.\n"

elif [ "$1" == "-h" ]; then
  echo ""
  echo "                   _                     _       "
  echo "  __ _ _ __   __ _| |_   _ _______   ___| |__    "
  echo " / _  |  _ \ / _  | | | | |_  / _ \ / __|  _ \   "
  echo "| (_| | | | | (_| | | |_| |/ /  __/_\__ \ | | |  "
  echo " \__ _|_| |_|\__ _|_|\__  /___\___(_)___/_| |_|  "
  echo "                      |___/      |               "
  echo "Instagram: rafael_cyber1 | V 1.4 |"
  echo "---------------------------------+"
  echo "analyze.sh [Argument] [URL]"
  echo "-h = Help"
  echo "---download"
  echo -e "---extrair.\n"
fi
