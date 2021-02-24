#!/bin/sh

#Will require sudo execution since certbot creates the
#files with root uid

#Due the sequential execution needed and the lack of pre-installed
#docker-compose on LA this script is used instead of a compose yml

docker network create opencart&&
mkdir -p letsencrypt/etc letsencrypt/var/lib &&
docker run -it --name certbot-opencart\
  -p 80:80 -p 443:443\
  -v "$PWD/letsencrypt/etc:/etc/letsencrypt"\
  -v "$PWD/letsencrypt/var/lib:/var/lib/letsencrypt"\
  certbot/certbot   certonly --standalone -d $HOSTNAME &&
mkdir -p nginx/cert nginx/conf.d nginx/templates &&
cp ./letsencrypt/etc/live/$HOSTNAME/fullchain.pem ./nginx/cert/&&
cp ./letsencrypt/etc/live/$HOSTNAME/privkey.pem ./nginx/cert/ &&
cp ./opencart.conf.template nginx/templates&&
docker run -d --network opencart --name opencart\
  --restart always\
  ameseguer/opencart&&
docker run  --network opencart --name nginx\
  --restart always\
  -p 80:80 -p 443:443\
  -e NGINX_HOST=$HOSTNAME\
  -v "$PWD/nginx/templates:/etc/nginx/templates"\
  -v "$PWD/nginx/cert:/etc/nginx/cert"\
  nginx 
