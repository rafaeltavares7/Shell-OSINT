#!/bin/bash

video_url=$2
source yt-dlp-env/bin/activate
pip install --upgrade yt-dlp

if [ "$1" == "---video" ]; then
  yt-dlp --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36" $video_url

elif [ "$1" == "---audio-mp3" ]; then
  yt-dlp -x --audio-format mp3 --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36" $video_url

elif [ "$1" == "---audio-m4a" ]; then
  yt-dlp -x --audio-format m4a --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36" $video_url

elif [ "$1" == "-h" ]; then
  echo "+---------------------------+"
  echo "| instagram: @rafael_cyber1 |"
  echo "|---------------------------|"
  echo "|--video-download.sh V.1.0--|"
  echo "+---------------------------+"
  echo "video-download.sh [Opção] [URL]"
  echo "-------------------------------"
  echo "Opções:"
  echo "---video = Donwload do Video"
  echo "---audio-mp3 = Download do Audio em mp3"
  echo -e "---audio-m4a = Download do Audio em m4a\n"
fi

echo -e "\nPra desativar o ambiente virtual digite o seguinte comando: deactivate\n"

# -x Pra extrair audios | --audio-format Pra definir o formato do audio | --user-agent Pra definir um user agent | -e é usado pra adcionar o \n pra pular 1 linha
