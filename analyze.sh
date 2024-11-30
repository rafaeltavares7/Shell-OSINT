#!/bin/bash

d=$1

wget -r -np -k -P analyzedownloads $d # Baixar o Site inteiro. -P Especifica que sera salvo no diretório analyzedownloads
# -r (recursivo): Faz o wget baixe a página inicial e, em seguida, siga os links encontrados
# -np (no parent): Isso significa que o wget não irá sair da área do site indicado (não seguirá links para fora do domínio).
# -k (convert): Converte os links internos no arquivo baixado, permitindo que você navegue no site offline.
# Buscar tudo dentro de (href)

clear

echo "+---------------------------+"
echo "| instagram: @rafael_cyber1 |"
echo "|---------------------------|"
echo "|------analyze.sh V.1.0-----|"
echo "+---------------------------+"
# Extrair o domínio da URL em $d
domain=$(echo $d | sed -E 's/^(https?:\/\/)?([^\/]+).*$/\2/')
domain=$(echo $domain | sed 's/^www\.//')
echo "Consulta WHOIS: $domain"
whois $domain | grep -E -i "Tech|admin|name serve" | sed 's/Registry Tech ID:.*//' |  sed 's/Tech Name:.*//' | sed 's/   Name Server:.*//' | sed '/^$/d'

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
echo -e "\nExtração de informações concluido."
# -o do grep faz ele imprimir apenas o que corresponde ao padrão.
# -P ativa o suporte à expressão regular Perl, que usar a sintaxe avançada
# \K. O \K diz ao grep para "descartar" o que tem antes dessa parte,
