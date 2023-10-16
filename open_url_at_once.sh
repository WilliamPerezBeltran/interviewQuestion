#! /bin/bash

# script to excute whole the urls from  file urls.txt 
# source : https://askubuntu.com/questions/356627/open-url-from-bash-script
# xdg-open abre la url por consola

for url in $(cat urls.txt); do
    xdg-open "$url"
done





