#!/bin/bash

cnpj=$1

# Usando curl para pegar a resposta JSON diretamente da API
json=$(curl -s "https://open.cnpja.com/office/$cnpj") # -s faz com que curl funcione de forma silenciosa

# jq para processar o JSON.
# -r é uma opção que significa "raw output", ou seja, ele retorna o valor sem aspas.
# .company.name: Esta é uma consulta ao JSON, acessando a chave company e, dentro dela, a chave name. O mesmo é repetido para todas as outras informações como taxId, company.founded, etc.

echo "+---------------------------+"
echo "| instagram: @rafael_cyber1 |"
echo "|---------------------------|"
echo "|---search-cnpj.sh V.1.0----|"
echo "+---------------------------+"

# Extraindo e formatando os dados com jq (como no exemplo anterior)
echo "Informações da Empresa:"
echo "-----------------------"
echo "Nome da Empresa: $(echo "$json" | jq -r '.company.name')"
echo "CNPJ: $(echo "$json" | jq -r '.taxId')"
echo "Data de Fundação: $(echo "$json" | jq -r '.company.founded')"
echo "Status: $(echo "$json" | jq -r '.status.text')"
echo "Natureza Jurídica: $(echo "$json" | jq -r '.company.nature.text')"
echo "Tamanho: $(echo "$json" | jq -r '.company.size.text')"
echo "Optante pelo Simples Nacional: $(echo "$json" | jq -r '.company.simples.optant')"
echo "Optante pelo Simei: $(echo "$json" | jq -r '.company.simei.optant')"

echo ""
echo "Sócios:"
echo "-------"
echo "$json" | jq -r '.company.members[] | " ID: \(.person.id), Nome: \(.person.name), CPF: \(.person.taxId), Idade: \(.person.age), Função: \(.role.text), Desde: \(.since)"'

echo ""
echo "Endereço:"
echo "---------"
echo "Rua: $(echo "$json" | jq -r '.address.street')"
echo "Número: $(echo "$json" | jq -r '.address.number')"
echo "Bairro: $(echo "$json" | jq -r '.address.district')"
echo "Cidade: $(echo "$json" | jq -r '.address.city')"
echo "Estado: $(echo "$json" | jq -r '.address.state')"
echo "CEP: $(echo "$json" | jq -r '.address.zip')"

echo ""
echo "Emails:"
echo "-------"
echo "$json" | jq -r '.emails[] | "Tipo: \(.ownership), Email: \(.address), Dominio: \(.domain)"'

echo ""
echo "Atividade Principal:"
echo "--------------------"
echo "Descrição: $(echo "$json" | jq -r '.mainActivity.text')"

echo ""
echo "Registro Estadual:"
echo "------------------"
echo "Número: $(echo "$json" | jq -r '.registrations[0].number')"
echo "Estado: $(echo "$json" | jq -r '.registrations[0].state')"
echo "Tipo: $(echo "$json" | jq -r '.registrations[0].type.text')"
echo "Status: $(echo "$json" | jq -r '.registrations[0].status.text')"

echo ""
echo "Última Atualização: $(echo "$json" | jq -r '.updated')"
