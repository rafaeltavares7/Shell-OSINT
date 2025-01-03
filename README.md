O repositório Tools é um projeto meu de desenvolvimento de ferramentas para estudos e fins éticos.

Ferramentas:

1. O analyze.sh: Ele baixa o site a partir da sua URL, também baixa todas as páginas do site alvo que encontrar pela URL. Em seguida, faz uma consulta WHOIS com vários filtros no resultado. Depois, filtra tudo o que foi baixado utilizando o grep -r para filtrar tudo o que estiver dentro de href e src, além de e-mails. Por fim, usa o exiftool para ler todos os metadados do site tambem faz consulta DNS do dominio usando o host, entre outras  coisas.

2. O enumdir.sh: Realiza a enumeração de diretórios e também captura os redirecionamentos.

3. enumdns.sh: Realiza a enumeração de DNS.

4. hash_crack.sh: Faz a quebra de hashes e também conta com um menu.

5. mr.sherlock.py: Foi inspirado no Sherlock, porém mais preciso. Atualmente, ele verifica 312 sites.

6. search-cnpj.sh: Faz consultas de CNPJs usando API.

7. wifi-deauth.sh: Usa o aireplay-ng pra fazer ataque deauth contra uma lista de MACs em loop infinito.

8. video-download.sh: Faz downloads de videos e audios, usando o yt-dlp.

9. brute-force.sh: Força bruta de senhas em: ssh, ftp.

10. ip-tools.sh: É um canivete suiço de ferramentas pra IPs.

Todas essas ferramentas são extremamente configuráveis.

git clone https://github.com/rafaelcyber1/Tools.git

cd Tools

bash install.sh
