#!/bin/bash

clear

echo -e "\033[0;32m     _          _ _\033[0m"
echo -e "\033[0;32m ___| |__   ___| | |___ _ __  _   _  \033[0m"
echo -e "\033[0;32m/ __|  _ \ / _ \ | / __|  _ \| | | | \033[0m"
echo -e "\033[0;32m\__ \ | | |  __/ | \__ \ |_) | |_| | \033[0m"
echo -e "\033[0;32m|___/_| |_|\___|_|_|___/  __/ \__  | \033[0m"
echo -e "\033[0;32m@rafael_cyber1 V 1.1   |_|    |___/  \033[0m"
echo ""

if [ "$1" == "---extract" ]; then
  d=$2
  echo -e "\033[0;32m[+] Extracting information from: $d\033[0m\n"
  # Extrair o domínio da URL em $d
  domainone=$(echo $d | sed -E 's/^(https?:\/\/)?([^\/]+).*$/\2/')
  domaintwo=$(echo $domainone | sed 's/^www\.//') # Para evitar erros ele retira (www) caso tenha.
  echo -e "\033[0;32m[+] Consulta WHOIS: $domain\033[0m"
  whois=$(whois $domaintwo | grep -E -i "Tech|admin|name serve" | sed 's/Registry Tech ID:.*//' |  sed 's/Tech Name:.*//' | sed 's/   Name Server:.*//' | sed '/^$/d')
  if [ -n "$whois" ]; then
    echo -e "\033[0;32m$whois\033[0m"
  fi

  echo -e "\n\033[0;32m[+] IP: $domain\033[0m"
  host=$(host $domaintwo | grep "has")
  if [ -n "$host" ]; then
    echo -e "\033[0;32m$host\033[0m"
  fi
  sleep 1

  echo -e "\n\033[0;32m[+] Encontrado em (href):\033[0m"
  href=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" $d | grep -oP 'href="\K[^"]+')
  if [ -n "$href" ]; then
    echo -e "\033[0;32m$href\033[0m"
  fi
  sleep 1

  echo -e "\n\033[0;32m[+] Encontrado em (src):\033[0m"
  src=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" $d | grep -oP 'src="\K[^"]+')
  if [ -n "$src" ]; then
    echo -e "\033[0;32m$src\033[0m"
  fi
  sleep 1

  echo -e "\n\033[0;32m[+] Emails:\033[0m"
  email=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" $d | grep -oP '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}')
  if [ -n "$email" ]; then
    echo -e "\033[0;32m$email\033[0m"
  fi
  sleep 1
  
  echo -e "\n\033[0;32m[+] Pesquisa com Shodan:\033[0m"
  result=$(host $domaintwo | grep 'has address' | head -n 1 | sed "s/$domaintwo has address //") # head -n 1 tras apenas o primeiro resultado
  results=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.shodan.io/host/$result" | grep -oP '(?<=Ports open: ).*(?=")') # grep -oP '(?<=Ports open: ).*(?=")') tras tudo depois de Ports open: e antes de "
  if [ -n "$results" ]; then
    echo -e "\033[0;32m$results\033[0m"
  fi

  echo -e "\n\033[0;32m[+] Extraction Finished\033[0m\n"

elif [ "$1" == "---dorks" ]; then
  site=$2
  echo -e "\n\033[0;32m[+] Search: $site\033[0m\n"

  json1=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_KEY_&cx=_ID_&q=site%3A${site}+%22admin%22+OR+%22login%22+OR+%22robots.txt%22");  alr=$(echo "$json1" | jq -r '.items[].link'); echo -e "\033[0;32m$alr\033[0m"
  sleep 1

  json2=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_KEY_&cx=_ID_&q=site%3A${site}+%22index%22+OR+%22assets%22+OR+%22server%22");  ias=$(echo "$json2" | jq -r '.items[].link'); echo -e "\033[0;32m$ias\033[0m"
  sleep 1

  json3=$(curl -s "https://www.googleapis.com/customsearch/v1?key=_KEY_&cx=_ID_&q=site%3A${site}+%22wp-json/wp/v2/users%22+OR+%22uploads%22+OR+%22email%22");  wue=$(echo "$json3" | jq -r '.items[].link'); echo -e "\033[0;32m$wue\033[0m"

  echo -e "\n\033[0;32m[+] Finished\033[0m\n"

elif [ "$1" == "---user" ]; then
  user=$2
  userm=$(echo "$user" | sed 's/^[a-z]/\U&/') # ^[a-z] Identifica a primeira letra do nome que está em minúscula \U& converte essa letra em maiúscula.
  # curl: É uma ferramenta de linha de comando para fazer requisições a URLs. Ele suporta vários protocolos, incluindo HTTP, HTTPS, FTP, entre outros.
  # -o /dev/null: Essa opção indica que a resposta do servidor (o corpo da resposta) deve ser descartada.
  # permite que você defina um formato customizado para a saída. A string "%{http_code}\n" instrui o curl a exibir apenas o código HTTP da resposta, como 200, 404, 500, etc...
  ### SITE LIST ###
  echo -e "\033[0;32m\n[+] Searching: $user\n\033[0m"
  vivaolinux=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.vivaolinux.com.br/~$user" | grep "200")
  if [ -n "$vivaolinux" ]; then
    echo -e "\033[0;32m[+] https://www.vivaolinux.com.br/~$user\033[0m"
  fi

  alura=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://cursos.alura.com.br/user/$user" | grep "200")
  if [ -n "$alura" ]; then
    echo -e "\033[0;32m[+] https://cursos.alura.com.br/user/$user\033[0m"
  fi

  bellingcat=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.bellingcat.com/author/$user/" | grep "200")
  if [ -n "$bellingcat" ]; then
    echo -e "\033[0;32m[+] https://www.bellingcat.com/author/$user/\033[0m"
  fi

  medium=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://medium.com/@$user" | grep 'property="og:url" content="https://medium.com/@')
  if [ -n "$medium" ]; then
    echo -e "\033[0;32m[+] https://medium.com/@$user\033[0m"
  fi

  epicdope=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.epicdope.com/author/$user/" | grep "200")
   if [ -n "$epicdope" ]; then
    echo -e "\033[0;32m[+] https://www.epicdope.com/author/$user/\033[0m"
  fi

  ufba=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://ufba.academia.edu/$user" | grep "200")
  if [ -n "$ufba" ]; then
    echo -e "\033[0;32m[+] https://ufba.academia.edu/$user\033[0m"
  fi

  insta=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.instagram.com/$user/" | grep 'href="https://www.instagram.com/')
  if [ -n "$insta" ]; then
    echo -e "\033[0;32m[+] https://www.instagram.com/$user\033[0m"
  fi

  threads=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.threads.net/@$user" | grep '"BarcelonaProfileDeletionReactivateTapFalcoEvent"')
  if [ -n "$threads" ]; then
    echo -e "\033[0;32m[+] https://www.threads.net/@$user\033[0m"
  fi

  mastodon=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://mastodon.social/@$user" | grep "200")
  if [ -n "$mastodon" ]; then
    echo -e "\033[0;32m[+] https://mastodon.social/@$user\033[0m"
  fi

  bsk=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://bsky.app/profile/$user.bsky.social" | grep "<title>@")
  if [ -n "$bsk" ]; then
    echo -e "\033[0;32m[+] https://bsky.app/profile/$user.bsky.social\033[0m"
  fi

  snapchat=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.snapchat.com/add/$user" | grep "200")
  if [ -n "$snapchat" ]; then
    echo -e "\033[0;32m[+] https://www.snapchat.com/add/$user\033[0m"
  fi

  facebook=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.facebook.com/$user/" | grep 'property="og:url" content="https://www.facebook.com/')
  if [ -n "$facebook" ]; then
    echo -e "\033[0;32m[+] https://www.facebook.com/$user/\033[0m"
  fi

  facebook=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.facebook.com/$userm/" | grep 'property="og:url" content="https://www.facebook.com/')
  if [ -n "$facebook" ]; then
    echo -e "\033[0;32m[+] https://www.facebook.com/$userm/\033[0m"
  fi

  youtube=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.youtube.com/@$user" | grep "200")
  if [ -n "$youtube" ]; then
    echo -e "\033[0;32m[+] https://www.youtube.com/@$user\033[0m"
  fi

  proton=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://protonvpn.com/blog/author/$user" | grep "200")
  if [ -n "$proton" ]; then
    echo -e "\033[0;32m[+] https://protonvpn.com/blog/author/$user\033[0m"
  fi

  kaart=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://menukaart.menu/user/$user" | grep "200")
  if [ -n "$kaart" ]; then
    echo -e "\033[0;32m[+] https://menukaart.menu/user/$user\033[0m"
  fi

  discord=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://discord.com/invite/$user" | grep '<link rel="canonical"')
  if [ -n "$discord" ]; then
    echo -e "\033[0;32m[+] https://discord.com/invite/$user\033[0m"
  fi

  purposegames=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.purposegames.com/user/$user" | grep "200")
  if [ -n "$purposegames" ]; then
    echo -e "\033[0;32m[+] https://www.purposegames.com/user/$user\033[0m"
  fi

  spatial=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.spatial.io/@$user" | grep '","displayName":"')
  if [ -n "$spatial" ]; then
    echo -e "\033[0;32m[+] https://www.spatial.io/@$user\033[0m"
  fi

  steamcommunity=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://steamcommunity.com/id/$user/" | grep 'https://steamcommunity.com/id/')
  if [ -n "$steamcommunity" ]; then
    echo -e "\033[0;32m[+] https://steamcommunity.com/id/$user/\033[0m"
  fi

  discuss=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://discuss.ai.google.dev/u/$user" | grep "200")
  if [ -n "$discuss" ]; then
    echo -e "\033[0;32m[+] https://discuss.ai.google.dev/u/$user\033[0m"
  fi
  sleep 1

  opera=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://forums.opera.com/user/$user" | grep "200")
  if [ -n "$opera" ]; then
    echo -e "\033[0;32m[+] https://forums.opera.com/user/$user\033[0m"
  fi

  tinder=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://tinder.com/@$user" | grep '"id":')
  if [ -n "$tinder" ]; then
    echo -e "\033[0;32m[+] https://tinder.com/@$user\033[0m"
  fi

  ipinfo=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://community.ipinfo.io/u/$user" | grep "200")
  if [ -n "$ipinfo" ]; then
    echo -e "\033[0;32m[+] https://community.ipinfo.io/u/$user\033[0m"
  fi

  infosec=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://infosec.exchange/@$user" | grep "200")
  if [ -n "$infosec" ]; then
    echo -e "\033[0;32m[+] https://infosec.exchange/@$user\033[0m"
  fi

  revistaforum=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://revistaforum.com.br/autor/$user.html" | grep "200")
  if [ -n "$revistaforum" ]; then
    echo -e "\033[0;32m[+] https://revistaforum.com.br/autor/$user.html\033[0m"
  fi

  freelancer=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.freelancer.com/u/$user" | grep "200")
  if [ -n "$freelancer" ]; then
    echo -e "\033[0;32m[+] https://www.freelancer.com/u/$user\033[0m"
  fi

  vk=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://vk.com/$user" | grep "302")
  if [ -n "$vk" ]; then
    echo -e "\033[0;32m[+] https://vk.com/$user\033[0m"
  fi

  devto=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://dev.to/$user" | grep "200")
  if [ -n "$devto" ]; then
    echo -e "\033[0;32m[+] https://dev.to/$user\033[0m"
  fi

  forumskali=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://forums.kali.org/u/$user" | grep "200")
  if [ -n "$forumskali" ]; then
    echo -e "\033[0;32m[+] https://forums.kali.org/u/$user\033[0m"
  fi

  auth0=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://community.auth0.com/u/$user/summary" | grep "200")
  if [ -n "$auth0" ]; then
    echo -e "\033[0;32m[+] https://community.auth0.com/u/$user/summary\033[0m"
  fi

  csdms=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://forum.csdms.io/u/$user/summary" | grep "200")
  if [ -n "$csdms" ]; then
    echo -e "\033[0;32m[+] https://forum.csdms.io/u/$user/summary\033[0m"
  fi

  vinteconto=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://vinteconto.com.br/public/profile/$user" | grep "200")
  if [ -n "$vinteconto" ]; then
    echo -e "\033[0;32m[+] https://vinteconto.com.br/public/profile/$user\033[0m"
  fi

  crackmes=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://crackmes.one/user/$user" | grep "200")
  if [ -n "$crackmes" ]; then
    echo -e "\033[0;32m[+] https://crackmes.one/user/$user\033[0m"
  fi

  itsfoss=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://itsfoss.com/author/$user/" | grep "200")
  if [ -n "$itsfoss" ]; then
    echo -e "\033[0;32m[+] https://itsfoss.com/author/$user/\033[0m"
  fi

  github=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://github.com/$user" | grep "200")
  if [ -n "$github" ]; then
    echo -e "\033[0;32m[+] https://github.com/$user\033[0m"
  fi

  gitlab=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://gitlab.com/$user" | grep "200")
  if [ -n "$gitlab" ]; then
    echo -e "\033[0;32m[+] https://gitlab.com/$user\033[0m"
  fi

  ask=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://ask.debxp.org/user/$user" | grep "200")
  if [ -n "$ask" ]; then
    echo -e "\033[0;32m[+] https://ask.debxp.org/user/$user\033[0m"
  fi

  geeksforgeeks=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.geeksforgeeks.org/user/$user/" | grep "200")
  if [ -n "$geeksforgeeks" ]; then
    echo -e "\033[0;32m[+] https://www.geeksforgeeks.org/user/$user/\033[0m"
  fi

  hackr=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://hackr.io/blog/author/$user" | grep "200")
  if [ -n "$hackr" ]; then
    echo -e "\033[0;32m[+] https://hackr.io/blog/author/$user\033[0m"
  fi

  servicos=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://servicos2.decea.mil.br/br-utm/wiki/user/$user" | grep "200")
  if [ -n "$servicos" ]; then
    echo -e "\033[0;32m[+] https://servicos2.decea.mil.br/br-utm/wiki/user/$user\033[0m"
  fi
  sleep 1

  softensistemas=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://docs.softensistemas.com.br/user/$user" | grep "200")
  if [ -n "$softensistemas" ]; then
    echo -e "\033[0;32m[+] https://docs.softensistemas.com.br/user/$user\033[0m"
  fi

  appsilon=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.appsilon.com/author/$user" | grep "200")
  if [ -n "$appsilon" ]; then
    echo -e "\033[0;32m[+] https://www.appsilon.com/author/$user\033[0m"
  fi

  kobotoolbox=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://community.kobotoolbox.org/u/$user/summary" | grep "200")
  if [ -n "$kobotoolbox" ]; then
   echo -e "\033[0;32m[+] https://community.kobotoolbox.org/u/$user/summary\033[0m"
  fi

  bloggravatar=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://blog.gravatar.com/author/$user/" | grep "200")
  if [ -n "$bloggravatar" ]; then
    echo -e "\033[0;32m[+] https://blog.gravatar.com/author/$user/\033[0m"
  fi

  dio=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.dio.me/users/$user" | grep "200")
  if [ -n "$dio" ]; then
    echo -e "\033[0;32m[+] https://www.dio.me/users/$user\033[0m"
  fi

  guj=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.guj.com.br/u/$user/summary" | grep "200")
  if [ -n "$guj" ]; then
    echo -e "\033[0;32m[+] https://www.guj.com.br/u/$user/summary\033[0m"
  fi

  spotify=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://open.spotify.com/user/$user" | grep "200")
  if [ -n "$spotify" ]; then
    echo -e "\033[0;32m[+] https://open.spotify.com/user/$user\033[0m"
  fi

  soundcloud=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://soundcloud.com/$user" | grep "200")
  if [ -n "$soundcloud" ]; then
    echo -e "\033[0;32m[+] https://soundcloud.com/$user\033[0m"
  fi

  last=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.last.fm/user/$user" | grep "200")
  if [ -n "$last" ]; then
    echo -e "\033[0;32m[+] https://www.last.fm/user/$user\033[0m"
  fi

  linktr=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://linktr.ee/$user" | grep 'content="https://linktr.ee/')
  if [ -n "$linktr" ]; then
    echo -e "\033[0;32m[+] https://linktr.ee/$user\033[0m"
  fi

  aboutme=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://about.me/$user" | grep "200")
  if [ -n "$aboutme" ]; then
    echo -e "\033[0;32m[+] https://about.me/$user\033[0m"
  fi

  wattpad=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.wattpad.com/user/$user" | grep "200")
  if [ -n "$wattpad" ]; then
    echo -e "\033[0;32m[+] https://www.wattpad.com/user/$user\033[0m"
  fi

  twitch=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.twitch.tv/$user" | grep 'href="https://www.twitch.tv/')
  if [ -n "$linktr" ]; then
    echo -e "\033[0;32m[+] https://www.twitch.tv/$user\033[0m"
  fi

  tiktok=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.tiktok.com/@$user" | grep 'uniqueId":')
  if [ -n "$tiktok" ]; then
    echo -e "\033[0;32m[+] https://www.tiktok.com/@$user\033[0m"
  fi

  kwai=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.kwai.com/@$user" | grep 'name="title" data-hid="title" content="')
  if [ -n "$kwai" ]; then
    echo -e "\033[0;32m[+] https://www.kwai.com/@$user\033[0m"
  fi

  snackvideo=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.snackvideo.com/@$user" | grep '"url":"https://www.snackvideo.com/@')
  if [ -n "$snackvideo" ]; then
    echo -e "\033[0;32m[+] https://www.snackvideo.com/@$user\033[0m"
  fi

  pinterest=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.pinterest.com/$user"/ | grep '":false,"username":"' | sed 's/","id":".*//' | sed 's/*.username//')
  if [ -n "$pinterest" ]; then
    echo -e "\033[0;32m[+] https://www.pinterest.com/$user/\033[0m"
  fi

  youpic=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://youpic.com/photographer/$user" | grep "200")
  if [ -n "$youpic" ]; then
    echo -e "\033[0;32m[+] https://youpic.com/photographer/$user\033[0m"
  fi

  eyeem=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.eyeem.com/u/$user" | grep "200")
  if [ -n "$eyeem" ]; then
    echo -e "\033[0;32m[+] https://www.eyeem.com/u/$user\033[0m"
  fi

  themeplaza=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://themeplaza.art/profile/$user" | grep '=user:')
  if [ -n "$themeplaza" ]; then
    echo -e "\033[0;32m[+] https://themeplaza.art/profile/$user\033[0m"
  fi
  sleep 1

  vimeo=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://vimeo.com/$user" | grep "200")
  if [ -n "$vimeo" ]; then
    echo -e "\033[0;32m[+] https://vimeo.com/$user\033[0m"
  fi

  imgsrc=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://imgsrc.ru/$user" | grep "200")
  if [ -n "$imgsrc" ]; then
    echo -e "\033[0;32m[+] https://imgsrc.ru/$user\033[0m"
  fi

  birdier=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://birdier.com/user/$user" | grep "200")
  if [ -n "$birdier" ]; then
    echo -e "\033[0;32m[+] https://birdier.com/user/$user\033[0m"
  fi

  booooom=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.booooooom.com/user/$user/" | grep "200")
  if [ -n "$booooom" ]; then
    echo -e "\033[0;32m[+] https://www.booooooom.com/user/$user/\033[0m"
  fi

  deviantart=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.deviantart.com/$user/gallery" | grep "200")
  if [ -n "$deviantart" ]; then
    echo -e "\033[0;32m[+] https://www.deviantart.com/$user/gallery\033[0m"
  fi

  dribbble=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://dribbble.com/$user" | grep "200")
  if [ -n "$dribbble" ]; then
    echo -e "\033[0;32m[+] https://dribbble.com/$user\033[0m"
  fi

  beebom=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://beebom.com/author/$user/" | grep "200")
  if [ -n "$beebom" ]; then
    echo -e "\033[0;32m[+] https://beebom.com/author/$user/\033[0m"
  fi

  odysee=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://odysee.com/@$user" | grep 'content="https://odysee.com/@')
  if [ -n "$odysee" ]; then
    echo -e "\033[0;32m[+] https://odysee.com/@$user\033[0m"
  fi

  pikabu=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://pikabu.ru/@$user" | grep "200")
  if [ -n "$pikabu" ]; then
    echo -e "\033[0;32m[+] https://pikabu.ru/@$user\033[0m"
  fi

  vakinha=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.vakinha.com.br/usuario/$user" | grep "200")
  if [ -n "$vakinha" ]; then
    echo -e "\033[0;32m[+] https://www.vakinha.com.br/usuario/$user\033[0m"
  fi

  godot=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://godot.community/user/$user" | grep "200")
  if [ -n "$godot" ]; then
    echo -e "\033[0;32m[+] https://godot.community/user/$user\033[0m"
  fi

  spiritfanfiction=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.spiritfanfiction.com/perfil/$user" | grep "200")
  if [ -n "$spiritfanfiction" ]; then
    echo -e "\033[0;32m[+] https://www.spiritfanfiction.com/perfil/$user\033[0m"
  fi

  wiki=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://wiki.benner.com.br/accessviolation/?qa=user/$user" | grep "200")
  if [ -n "$wiki" ]; then
    echo -e "\033[0;32m[+] https://wiki.benner.com.br/accessviolation/?qa=user/$user\033[0m"
  fi

  aniworld=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://aniworld.to/user/profil/$user" | grep "200")
  if [ -n "$aniworld" ]; then
    echo -e "\033[0;32m[+] https://aniworld.to/user/profil/$user\033[0m"
  fi

  myanimelist=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://myanimelist.net/profile/$user" | grep "200")
  if [ -n "$myanimelist" ]; then
    echo -e "\033[0;32m[+] https://myanimelist.net/profile/$user\033[0m"
  fi

  allmylinks=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://allmylinks.com/$user" | grep "200")
  if [ -n "$allmylinks" ]; then
    echo -e "\033[0;32m[+] https://allmylinks.com/$user\033[0m"
  fi

  fabdom=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.fandom.com/u/$user" | grep "200")
  if [ -n "$fandom" ]; then
    echo -e "\033[0;32m[+] https://www.fandom.com/u/$user\033[0m"
  fi

  fandom=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.fandom.com/u/$userm" | grep "200")
  if [ -n "$fandom" ]; then
    echo -e "\033[0;32m[+] https://www.fandom.com/u/$userm\033[0m"
  fi

  gamespot=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.gamespot.com/profile/$user/" | grep '<a href="<%= user.url %>"><%= user.username %></a> <%= body %>  </div>')
  if [ -n "$gamespot" ]; then
    echo -e "\033[0;32m[+] https://www.gamespot.com/profile/$user/\033[0m"
  fi

  ludopedia=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://ludopedia.com.br/usuario/$user" | grep '<li><a href="https://ludopedia.com.br/colecao?usuario=')
  if [ -n "$ludopedia" ]; then
    echo -e "\033[0;32m[+] https://ludopedia.com.br/usuario/$user\033[0m"
  fi
  sleep 1

  tumblr=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.tumblr.com/$user" | grep "200")
  if [ -n "$tumblr" ]; then
    echo -e "\033[0;32m[+] https://www.tumblr.com/$user\033[0m"
  fi

  framapiaf=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://framapiaf.org/@$user" | grep "200")
  if [ -n "$framapiaf" ]; then
    echo -e "\033[0;32m[+] https://framapiaf.org/@$user\033[0m"
  fi

  tumblrc=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.tumblr.com/communities/$user" | grep "200")
  if [ -n "$tumblrc" ]; then
    echo -e "\033[0;32m[+] https://www.tumblr.com/communities/$user\033[0m"
  fi

  myspace=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://myspace.com/$user" | grep "200")
  if [ -n "$myspace" ]; then
    echo -e "\033[0;32m[+] https://myspace.com/$user\033[0m"
  fi

  ngl=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://ngl.link/$user" | grep "200")
  if [ -n "$ngl" ]; then
    echo -e "\033[0;32m[+] https://ngl.link/$user\033[0m"
  fi

  interpals=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.interpals.net/$user" | grep '<p style="font-size: ')
  if [ -n "$interpals" ]; then
    echo -e "\033[0;32m[+] https://www.interpals.net/$user\033[0m"
  fi

  cups=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.7cups.com/@$user" | grep "200")
  if [ -n "$cups" ]; then
    echo -e "\033[0;32m[+] https://www.7cups.com/@$user\033[0m"
  fi

  disqus=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://disqus.com/by/$user/" | grep "200")
  if [ -n "$disqus" ]; then
    echo -e "\033[0;32m[+] https://disqus.com/by/$user/\033[0m"
  fi

  disquis=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://disqus.com/by/$userm/" | grep "200")
  if [ -n "$disquis" ]; then
    echo -e "\033[0;32m[+] https://disqus.com/by/$userm/\033[0m"
  fi

  homeassistantbrasil=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://homeassistantbrasil.com.br/u/$user/summary" | grep "200")
  if [ -n "$homeassistantbrasil" ]; then
    echo -e "\033[0;32m[+] https://homeassistantbrasil.com.br/u/$user/summary\033[0m"
  fi

  itch=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://itch.io/profile/$user" | grep "200")
  if [ -n "$itch" ]; then
    echo -e "\033[0;32m[+] https://itch.io/profile/$user\033[0m"
  fi

  flickr=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.flickr.com/people/$user" | grep "200")
  if [ -n "$flickr" ]; then
    echo -e "\033[0;32m[+] https://www.flickr.com/people/$user\033[0m"
  fi

  passes=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.passes.com/$user" | grep '@')
  if [ -n "$passes" ]; then
    echo -e "\033[0;32m[+] https://www.passes.com/$user\033[0m"
  fi

  dmoj=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://dmoj.ca/user/$user" | grep "200")
  if [ -n "$dmoj" ]; then
    echo -e "\033[0;32m[+] https://dmoj.ca/user/$user\033[0m"
  fi

  blipfoto=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.blipfoto.com/$user" | grep "200")
  if [ -n "$blipfoto" ]; then
    echo -e "\033[0;32m[+] https://www.blipfoto.com/$user\033[0m"
  fi

  blogbang=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://blog.bang.com/author/$user/" | grep "200")
  if [ -n "$blogbang" ]; then
    echo -e "\033[0;32m[+] https://blog.bang.com/author/$user/\033[0m"
  fi

  blogspot=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://$user.blogspot.com/" | grep "200")
  if [ -n "$blogspot" ]; then
    echo -e "\033[0;32m[+] https://$user.blogspot.com/\033[0m"
  fi

  scratch=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://scratch.mit.edu/users/$user/" | grep "200")
  if [ -n "$scratch" ]; then
    echo -e "\033[0;32m[+] https://scratch.mit.edu/users/$user/\033[0m"
  fi

  paltalk=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.paltalk.com/people/users/$user/index.wmt" | grep 'content="width=device-width"/><title>Free Chat with')
  if [ -n "$paltalk" ]; then
    echo -e "\033[0;32m[+] https://www.paltalk.com/people/users/$user/index.wmt\033[0m"
  fi

  note=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://note.com/$user" | grep "200")
  if [ -n "$note" ]; then
    echo -e "\033[0;32m[+] https://note.com/$user\033[0m"
  fi
  sleep 1

  contws=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://cont.ws/@$user" | grep "200")
  if [ -n "$contws" ]; then
    echo -e "\033[0;32m[+] https://cont.ws/@$user\033[0m"
  fi

  ifunny=$(curl -A "Mozilla/5.0 (Windows NT 6.3; Trident/7.0; AS; en-US) like Gecko" -o /dev/null -s -w "%{http_code}\n" "https://ifunny.co/user/$user" | grep "200")
  if [ -n "$ifunny" ]; then
    echo -e "\033[0;32m[+] https://ifunny.co/user/$user\033[0m"
  fi

  polyvore=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://polyvore.ch/author/$user/" | grep "200")
  if [ -n "$polyvore" ]; then
    echo -e "\033[0;32m[+] https://polyvore.ch/author/$user/\033[0m"
  fi

  mk=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://mk-auth.com.br/members/$user" | grep "200")
  if [ -n "$mk" ]; then
    echo -e "\033[0;32m[+] https://mk-auth.com.br/members/$user\033[0m"
  fi

  xcp=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://xcp-ng.org/forum/user/$user" | grep "200")
  if [ -n "$xcp" ]; then
    echo -e "\033[0;32m[+] https://xcp-ng.org/forum/user/$user\033[0m"
  fi

  xcpg=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://xcp-ng.org/forum/groups/$user" | grep "200")
  if [ -n "$xcpg" ]; then
    echo -e "\033[0;32m[+] https://xcp-ng.org/forum/groups/$user\033[0m"
  fi

  livejournal=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://$user.livejournal.com/" | grep "200")
  if [ -n "$livejournal" ]; then
    echo -e "\033[0;32m[+] https://$user.livejournal.com/\033[0m"
  fi

  flipboard=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://flipboard.com/@$user" | grep "200")
  if [ -n "$flipboard" ]; then
    echo -e "\033[0;32m[+] https://flipboard.com/@$user\033[0m"
  fi

  elipse=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://forum.elipse.com.br/u/$user/summary" | grep "200")
  if [ -n "$elipse" ]; then
    echo -e "\033[0;32m[+] https://forum.elipse.com.br/u/$user/summary\033[0m"
  fi

  hebrew=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://qa.hebrewbooks.org/user/$user" | grep "200")
  if [ -n "$hebrew" ]; then
    echo -e "\033[0;32m[+] https://qa.hebrewbooks.org/user/$user\033[0m"
  fi

  babelcube=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.babelcube.com/user/$user" | grep "200")
  if [ -n "$babelcube" ]; then
    echo -e "\033[0;32m[+] https://www.babelcube.com/user/$user\033[0m"
  fi

  endian=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://endian.eth0.com.br/forums/profile/$user/" | grep "200")
  if [ -n "$endian" ]; then
    echo -e "\033[0;32m[+] https://endian.eth0.com.br/forums/profile/$user/\033[0m"
  fi

  behance=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.behance.net/$user?tracking_source=search_projects" | grep "200")
  if [ -n "$behance" ]; then
    echo -e "\033[0;32m[+] https://www.behance.net/$user?tracking_source=search_projects\033[0m"
  fi

  fotki=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://members.fotki.com/$user/about/" | grep "200")
  if [ -n "$fotki" ]; then
    echo -e "\033[0;32m[+] https://members.fotki.com/$user/about/\033[0m"
  fi

  kiwibox=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.kiwibox.com/author/$user/" | grep "200")
  if [ -n "$kiwibox" ]; then
    echo -e "\033[0;32m[+] https://www.kiwibox.com/author/$user/\033[0m"
  fi

  asana=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://forum.asana.com/u/$user/summary" | grep "200")
  if [ -n "$asana" ]; then
    echo -e "\033[0;32m[+] https://forum.asana.com/u/$user/summary\033[0m"
  fi

  ### SITE POR LIST ###
  garotocomlocal=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://garotocomlocal.com.br/$user/" | grep "200")
  if [ -n "$garotocomlocal" ]; then
    echo -e "\033[0;32m[+] https://garotocomlocal.com.br/$user/\033[0m"
  fi

  tnaflix=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.tnaflix.com/profile/$user" | grep "200")
  if [ -n "$tnaflix" ]; then
    echo -e "\033[0;32m[+] https://www.tnaflix.com/profile/$user\033[0m"
  fi

  hentai3=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://3hentai.net/artists/$user" | grep "200")
  if [ -n "$hentai3" ]; then
    echo -e "\033[0;32m[+] https://3hentai.net/artists/$user\033[0m"
  fi
  sleep 1

  sexxy=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://sexxystories.com/author/$user/" | grep "200")
  if [ -n "$sexxy" ]; then
    echo -e "\033[0;32m[+] https://sexxystories.com/author/$user/\033[0m"
  fi

  porno=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://porno-geschichten.com/$user/" | grep "200")
  if [ -n "$porno" ]; then
    echo -e "\033[0;32m[+] https://porno-geschichten.com/$user/\033[0m"
  fi

  lushstories=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.lushstories.com/profile/$user" | grep "200")
  if [ -n "$lushstories" ]; then
    echo -e "\033[0;32m[+] https://www.lushstories.com/profile/$user\033[0m"
  fi

  lushstoriesm=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.lushstories.com/profile/$userm" | grep "200")
  if [ -n "$lushstoriesm" ]; then
    echo -e "\033[0;32m[+] https://www.lushstories.com/profile/$userm\033[0m"
  fi

  literotica=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.literotica.com/authors/$user" | grep "200")
  if [ -n "$literotica" ]; then
    echo -e "\033[0;32m[+] https://www.literotica.com/authors/$user\033[0m"
  fi

  literoticam=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.literotica.com/authors/$userm" | grep "200")
  if [ -n "$literoticam" ]; then
    echo -e "\033[0;32m[+] https://www.literotica.com/authors/$userm\033[0m"
  fi

  hentaicity=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.hentaicity.com/profile/$user/" | grep "200")
  if [ -n "$hentaicity" ]; then
    echo -e "\033[0;32m[+] https://www.hentaicity.com/profile/$user/\033[0m"
  fi

  xvideo=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.xvideos.com/$user" | grep "200")
  if [ -n "$xvideo" ]; then
    echo -e "\033[0;32m[+] https://www.xvideos.com/$user\033[0m"
  fi

  archivebate=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "http://archivebate.pro/profile/$user" | grep "200")
  if [ -n "$archivebate" ]; then
    echo -e "\033[0;32m[+] http://archivebate.pro/profile/$user\033[0m"
  fi

  admireme=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://admireme.vip/$user/" | grep "200")
  if [ -n "$admireme" ]; then
    echo -e "\033[0;32m[+] https://admireme.vip/$user/\033[0m"
  fi

  allthingsworn=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.allthingsworn.com/profile/$user" | grep "200")
  if [ -n "$allthingsworn" ]; then
    echo -e "\033[0;32m[+] https://www.allthingsworn.com/profile/$user\033[0m"
  fi

  xhamster=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://xhamster.com/users/$user" | grep "200")
  if [ -n "$xhamster" ]; then
    echo -e "\033[0;32m[+] https://xhamster.com/users/$user\033[0m"
  fi

  xhamsterc=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://xhamster.com/channels/$user" | grep "200")
  if [ -n "$xhamsterc" ]; then
    echo -e "\033[0;32m[+] https://xhamster.com/channels/$user\033[0m"
  fi

  xhamsterp=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://xhamster.com/pornstars/$user" | grep "200")
  if [ -n "$xhamsterp" ]; then
    echo -e "\033[0;32m[+] https://xhamster.com/pornstars/$user\033[0m"
  fi

  youpornu=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.youporn.com/uservids/ph-$user/" | grep "200")
  if [ -n "$youpornu" ]; then
    echo -e "\033[0;32m[+] https://www.youporn.com/uservids/ph-$user\033[0m"
  fi

  youpornc=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.youporn.com/channel/$user/" | grep "200")
  if [ -n "$youpornc" ]; then
    echo -e "\033[0;32m[+] https://www.youporn.com/channel/$user/\033[0m"
  fi

  youpornp=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.youporn.com/pornstar/$user/" | grep "200")
  if [ -n "$youpornp" ]; then
    echo -e "\033[0;32m[+] https://www.youporn.com/pornstar/$user/\033[0m"
  fi

  pornhubu=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.pornhub.com/users/$user" | grep "200")
  if [ -n "$pornhubu" ]; then
    echo -e "\033[0;32m[+] https://www.pornhub.com/users/$user\033[0m"
  fi

  pornhubm=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.pornhub.com/model/$user" | grep "200")
  if [ -n "$pornhubm" ]; then
    echo -e "\033[0;32m[+] https://www.pornhub.com/model/$user\033[0m"
  fi

  pornhubc=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.pornhub.com/channels/$user" | grep "200")
  if [ -n "$pornhubc" ]; then
    echo -e "\033[0;32m[+] https://www.pornhub.com/channels/$user\033[0m"
  fi
  sleep 1

  redtubeu=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.redtube.com.br/users/$user" | grep "200")
  if [ -n "$redtubeu" ]; then
    echo -e "\033[0;32m[+] https://www.redtube.com.br/users/$user\033[0m"
  fi

  redtubec=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.redtube.com.br/channels/$user" | grep "200")
  if [ -n "$redtubec" ]; then
    echo -e "\033[0;32m[+] https://www.redtube.com.br/channels/$user\033[0m"
  fi

  eplay=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.eplay.com/$user" | grep "200")
  if [ -n "$eplay" ]; then
    echo -e "\033[0;32m[+] https://www.eplay.com/$user\033[0m"
  fi

  eporneru=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.eporner.com/profile/$user/" | grep "200")
  if [ -n "$eporneru" ]; then
    echo -e "\033[0;32m[+] https://www.eporner.com/profile/$user/\033[0m"
  fi

  epornerc=$(curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" "https://www.eporner.com/channel/$user/" | grep '<title>' | sed 's/Porn Videos - EPORNER: HD Porn Tube//' | sed 's/<title>//g; s/<\/title>//g')
  if [ -n "$epornerc" ]; then
    echo -e "\033[0;32m[+] https://www.eporner.com/channel/$user/\033[0m"
  fi

  xcams=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.xcams.cam/en/profile/$user/" | grep "200")
  if [ -n "$xcams" ]; then
    echo -e "\033[0;32m[+] https://www.xcams.cam/en/profile/$user/\033[0m"
  fi

  pwa=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://pwa.oohcams.com/details/$user" | grep "200")
  if [ -n "$pwa" ]; then
    echo -e "\033[0;32m[+] https://pwa.oohcams.com/details/$user\033[0m"
  fi

  nudespuri=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.nudespuri.com/webcams/$user" | grep "200")
  if [ -n "$nudespuri" ]; then
    echo -e "\033[0;32m[+] https://www.nudespuri.com/webcams/$user\033[0m"
  fi

  sexlog=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://pt-br.sexlog.com/u/$user" | grep "200")
  if [ -n "$sexlog" ]; then
    echo -e "\033[0;32m[+] https://pt-br.sexlog.com/u/$user\033[0m"
  fi

  muyzorrasc=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.muyzorras.com/canales/$user" | grep "200")
  if [ -n "$muyzorrasc" ]; then
    echo -e "\033[0;32m[+] https://www.muyzorras.com/canales/$user\033[0m"
  fi

  muyzorras=$(curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:112.0) Gecko/20100101 Firefox/112.0 (pt-BR)" -o /dev/null -s -w "%{http_code}\n" "https://www.muyzorras.com/usuarios/$user" | grep "200")
  if [ -n "$muyzorras" ]; then
    echo -e "\033[0;32m[+] https://www.muyzorras.com/usuarios/$user\033[0m"
  fi

  echo -e "\n\033[0;32m[+] Research Completed.\033[0m\n"

elif [ "$1" == "-h" ]; then
  echo -e "\033[0;32mCOMMANDS:\033[0m"
  echo -e "\033[0;32mshellspy.sh ---extract [URL]\033[0m"
  echo -e "\033[0;32mshellspy.sh ---dorks [DOMAIN]\033[0m"
  echo -e "\033[0;32mshellspy.sh ---user [USER]\033[0m"
  echo -e "\033[0;32mshellspy.sh -h\033[0m"
fi
