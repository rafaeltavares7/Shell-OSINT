#!/bin/bash

d=$2

user_agents=(
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:112.0) Gecko/20100101 Firefox/112.0"
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Version/13.1 Safari/537.36"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Edg/112.0.1722.64 Safari/537.36"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Opera/72.0.3815.4007 Safari/537.36"
  "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:79.0) Gecko/20100101 Firefox/79.0"
  "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36 Edge/91.0.864.64"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36"
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Version/13.1.1 Safari/537.36"
  "Mozilla/5.0 (Windows NT 6.3; Trident/7.0; AS; en-US) like Gecko"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:54.0) Gecko/20100101 Firefox/54.0"
  "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101 Firefox/64.0"
) # lista de users agents

# Escolher um User-Agent aleatório da lista
selected_agent=${user_agents[$RANDOM % ${#user_agents[@]}]}
cookie_file="wordlists/cookies.txt" # armazena o cookie do site

if [ "$1" == "---download" ]; then

  mkdir -p analyzedownloads && wget -r -np -k -P analyzedownloads --wait=1 --random-wait --user-agent="$selected_agent" --load-cookies="$cookie_file" $d # Baixar o Site inteiro. -P Especifica que sera salvo no diretório analyzedownloads
  # -r (recursivo): Faz o wget baixe a página inicial e, em seguida, siga os links encontrados
  # -np (no parent): Isso significa que o wget não irá sair da área do site indicado (não seguirá links para fora do domínio).
  # -k (convert): Converte os links internos no arquivo baixado, permitindo que você navegue no site offline.
  # Buscar tudo dentro de (href)

  clear
  
  echo ""
  echo "                            000000000000000"
  echo "                        000000000000000000000000"
  echo "                     000000000000000000000000000000"
  echo "                  00000000000000000000000000000000000"
  echo "                000000000000               00000000000"
  echo "               0000000000                     00000000000"
  echo "             0000000000    analyze.sh V.1.3      000000000"
  echo "            000000000     0000000000000000000      00000000"
  echo "           00000000     instagram: @rafael_cyber1   00000000"
  echo "           0000000     00000000                      00000000"
  echo "          0000000     0000000                         0000000"
  echo "          0000000    000000                           00000000"
  echo "         00000000    00000                             0000000"
  echo "         0000000                                       0000000"
  echo "         0000000                                       0000000"
  echo "         0000000                                       0000000"
  echo "          0000000                                      0000000"
  echo "          0000000                                     0000000"
  echo "           0000000                                   00000000"
  echo "           00000000                                 00000000"
  echo "            00000000                               00000000"
  echo "             000000000                            00000000"
  echo "            000000000000                       0000000000"
  echo "          00000000000000000                 000000000000"
  echo "         000000000000000000000000       000000000000000"
  echo "       0000000000000000000000000000000000000000000000"
  echo "      00000000000000000  00000000000000000000000000"
  echo "    000000000000000000     0000000000000000000"
  echo "  0000000000000000000"
  echo " 0000000000000000000"
  echo "0000000000000000000"
  echo "000000000000000000"
  echo ""
  # Extrair o domínio da URL em $d
  domain=$(echo $d | sed -E 's/^(https?:\/\/)?([^\/]+).*$/\2/')
  domain=$(echo $domain | sed 's/^www\.//') # Para evitar erros ele retira (www) caso tenha.
  echo "Consulta WHOIS: $domain"
  whois $domain | grep -E -i "Tech|admin|name serve" | sed 's/Registry Tech ID:.*//' |  sed 's/Tech Name:.*//' | sed 's/   Name Server:.*//' | sed '/^$/d'

  echo -e "\nIP: $domain"
  host $domain | grep "has" | sed 's/.* //'

  echo -e "\nEncontrado em (href):"
  grep -r -oP -h 'href="\K[^"]+' analyzedownloads

  # Buscar tudo dentro de (src)
  echo -e "\nEncontrado em (src):"
  grep -r -oP -h 'src="\K[^"]+' analyzedownloads

  # Busca por emails
  echo -e "\nEmails:"
  grep -r -oP -h '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}' analyzedownloads

  # sed remove informações da resposta como informações inuteis ou inrelevantes
  echo -e "\nConsulta Exiftool:"
  exiftool -r analyzedownloads | sed 's/File Size.*//' | sed 's/MIME Type.*//' | sed 's/File Type.*//' | sed 's/Derived From Instance ID.*//' | sed 's/Derived From Document ID.*//' | sed 's/History Instance ID.*//' | sed 's/Derived From Original Document ID.*//' | sed 's/Document ID.*//' | sed 's/Original Document ID.*//' | sed 's/Instance ID.*//' | sed 's/History Parameters.*//' | sed 's/History Action.*//' | sed '/^$/d'
  
  echo -e "\nPesquisa com Dorks:" # usa a API do google PSE. Pressisa do KEY e do ID
  json1=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KEY_&cx=_YOUR_ID_&q=site:${domain}")
  echo "$json1" | jq -r '.items[].link'

  json2=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KEY_&cx=_YOUR_ID_&q=site:${domain}&start=11&num=10")
  echo "$json2" | jq -r '.items[].link'

  json3=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KAY_&cx=_YOUR_ID_&q=site:${domain}&start21=&num=10")
  echo "$json2" | jq -r '.items[].link'

  echo -e "\nTextos encontrados:"
  echo "$json1" | jq -r '.items[].snippet'
  echo "$json2" | jq -r '.items[].snippet'
  echo "$json3" | jq -r '.items[].snippet'

  echo -e "\nExtração de informações concluido."
  # -o do grep faz ele imprimir apenas o que corresponde ao padrão.
  # -P ativa o suporte à expressão regular Perl, que usar a sintaxe avançada
  # \K. O \K diz ao grep para "descartar" o que tem antes dessa parte,

elif [ "$1" == "---extrair" ]; then

  echo ""
  echo "                            000000000000000"
  echo "                        000000000000000000000000"
  echo "                     000000000000000000000000000000"
  echo "                  00000000000000000000000000000000000"
  echo "                000000000000               00000000000"
  echo "               0000000000                     00000000000"
  echo "             0000000000    analyze.sh V.1.3      000000000"
  echo "            000000000     0000000000000000000      00000000"
  echo "           00000000     instagram: @rafael_cyber1   00000000"
  echo "           0000000     00000000                      00000000"
  echo "          0000000     0000000                         0000000"
  echo "          0000000    000000                           00000000"
  echo "         00000000    00000                             0000000"
  echo "         0000000                                       0000000"
  echo "         0000000                                       0000000"
  echo "         0000000                                       0000000"
  echo "          0000000                                      0000000"
  echo "          0000000                                     0000000"
  echo "           0000000                                   00000000"
  echo "           00000000                                 00000000"
  echo "            00000000                               00000000"
  echo "             000000000                            00000000"
  echo "            000000000000                       0000000000"
  echo "          00000000000000000                 000000000000"
  echo "         000000000000000000000000       000000000000000"
  echo "       0000000000000000000000000000000000000000000000"
  echo "      00000000000000000  00000000000000000000000000"
  echo "    000000000000000000     0000000000000000000"
  echo "  0000000000000000000"
  echo " 0000000000000000000"
  echo "0000000000000000000"
  echo "000000000000000000"
  echo ""

  domain=$(echo $d | sed -E 's/^(https?:\/\/)?([^\/]+).*$/\2/')
  domain=$(echo $domain | sed 's/^www\.//') # Para evitar erros ele retira (www) caso tenha.
  echo "Consulta WHOIS: $domain"
  whois $domain | grep -E -i "Tech|admin|name serve" | sed 's/Registry Tech ID:.*//' |  sed '>

  echo -e "\nIP: $domain"
  host $domain | grep "has" | sed 's/.* //'

  echo -e "\nEncontrado em (href):"
  curl -s -A "$selected_agent" -b "$cookie_file" -c "$cookie_file" $d | grep -oP 'href="\K[^"]+'

  echo -e "\nEncontrado em (src):"
  curl -s -A "$selected_agent" -b "$cookie_file" -c "$cookie_file" $d | grep -oP 'src="\K[^"]+'

  echo -e "\nEmails:" 
  curl -s -A "$selected_agent" -b "$cookie_file" -c "$cookie_file" $d | grep -oP '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}'
  
  echo -e "\nPesquisa com Dorks:"
  json1=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KEY_&cx=_YOUR_ID_&q=site:${domain}")
  echo "$json1" | jq -r '.items[].link'

  json2=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KEY_&cx=_YOUR_ID_&q=site:${domain}&start=11&num=10")
  echo "$json2" | jq -r '.items[].link'

  json3=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_YOUR_KEY_&cx=_YOUR_ID_&q=site:${domain}&start21=&num=10")
  echo "$json2" | jq -r '.items[].link'

  echo -e "\nTextos encontrados:"
  echo "$json1" | jq -r '.items[].snippet'
  echo "$json2" | jq -r '.items[].snippet'
  echo "$json3" | jq -r '.items[].snippet'

  echo -e "\nExtração de informações concluido.\n"

elif [ "$1" == "-h" ]; then

  echo ""
  echo "                            000000000000000"
  echo "                        000000000000000000000000"
  echo "                     000000000000000000000000000000"
  echo "                  00000000000000000000000000000000000"
  echo "                000000000000               00000000000"
  echo "               0000000000                     00000000000"
  echo "             0000000000    analyze.sh V.1.3      000000000"
  echo "            000000000     0000000000000000000      00000000"
  echo "           00000000     instagram: @rafael_cyber1   00000000"
  echo "           0000000     00000000                      00000000"
  echo "          0000000     0000000                         0000000"
  echo "          0000000    000000                           00000000"
  echo "         00000000    00000                             0000000"
  echo "         0000000                                       0000000"
  echo "         0000000                                       0000000"
  echo "         0000000                                       0000000"
  echo "          0000000                                      0000000"
  echo "          0000000                                     0000000"
  echo "           0000000                                   00000000"
  echo "           00000000                                 00000000"
  echo "            00000000                               00000000"
  echo "             000000000                            00000000"
  echo "            000000000000                       0000000000"
  echo "          00000000000000000                 000000000000"
  echo "         000000000000000000000000       000000000000000"
  echo "       0000000000000000000000000000000000000000000000"
  echo "      00000000000000000  00000000000000000000000000"
  echo "    000000000000000000     0000000000000000000"
  echo "  0000000000000000000"
  echo " 0000000000000000000"
  echo "0000000000000000000"
  echo "000000000000000000"
  echo ""

  echo -e "\nanalyze.sh [Argument] [URL]\n"
  echo -e "\n-h = Help\n"
  echo -e "\n---download = Download para Analise uma  profunda.\n"
  echo -e "\n---extrair = Extrair URLs e emails do codigo fonte.\n"
fi
