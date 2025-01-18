O repositório Tools é um projeto meu de desenvolvimento de ferramentas para estudos e fins éticos.

Ferramentas:

1. O analyze.sh: Ele baixa o site a partir da sua URL, também baixa todas as páginas do site alvo que encontrar pela URL. Em seguida, faz uma consulta WHOIS com vários filtros no resultado. Depois, filtra tudo o que foi baixado utilizando o grep -r para filtrar tudo o que estiver dentro de href e src, além de e-mails. Por fim, usa o exiftool para ler todos os metadados do site tambem faz consulta DNS do dominio usando o host, entre outras  coisas.

2. enum.sh: È um enumerador de diretorios e subdomonios.

3. hash_crack.sh: Faz a quebra de hashes e também conta com um menu.

4. sherlock.sh: Foi inspirado no Sherlock, porém mais preciso. Atualmente, ele verifica cerca de 150 sites.

5. search-cnpj.sh: Faz consultas de CNPJs usando API.

6. wifi-deauth.sh: Usa o aireplay-ng pra fazer ataque deauth contra uma lista de MACs em loop infinito.

7. video-download.sh: Faz downloads de videos e audios, usando o yt-dlp.

8. brute-force.sh: Força bruta de senhas em: ssh, ftp, pop3.

9. ip-tools.sh: É um canivete suiço de ferramentas pra IPs.

Todas essas ferramentas são extremamente configuráveis.

git clone https://github.com/rafaelcyber1/Tools.git

cd Tools

bash install.sh
