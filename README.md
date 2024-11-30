O repositório Tools é um projeto meu de desenvolvimento de ferramentas hacker para estudos e fins éticos.

Ferramentas:

1. O analyze.sh: Ele baixa o site a partir da sua URL, também baixa todas as páginas do site alvo que encontrar pela URL. Em seguida, faz uma consulta WHOIS com vários filtros no resultado. Depois, filtra tudo o que foi baixado utilizando o grep -r para filtrar tudo o que estiver dentro de href e src, além de e-mails. Por fim, usa o exiftool para ler todos os metadados do site.

2. O enumdir.sh: Realiza a enumeração de diretórios e também captura os redirecionamentos.

3. enumdns.sh: Realiza a enumeração de DNS.

4. hash_crack.sh: Faz a quebra de hashes e também conta com um menu.

5. pingscan.sh: Pode ser usado para verificar quantos dispositivos estão conectados a uma rede.

6. reverse_dns.sh: Realiza uma busca reversa de DNS.

7. scanner.sh: Escaneia domínios e IPs, encontra portas abertas e, às vezes, consegue identificar o banner da porta.

8. mr.sherlock.py: Foi inspirado no Sherlock, porém mais preciso. Atualmente, ele verifica 240 sites.

Todas essas ferramentas são extremamente configuráveis.

git clone https://github.com/rafaelcyber1/Tools.git
cd Tools
python3 install-packages.py
apt install exiftool
