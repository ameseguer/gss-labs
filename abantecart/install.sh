docker network create abantecart&&
mkdir -p letsencrypt/etc letsencrypt/var/lib &&
docker run -it --name certbot-abantecart\
  -p 80:80 -p 443:443\
  -v "$PWD/letsencrypt/etc:/etc/letsencrypt"\
  -v "$PWD/letsencrypt/var/lib:/var/lib/letsencrypt"\
  certbot/certbot   certonly --standalone -d $HOSTNAME &&
mkdir -p certs &&
cp ./letsencrypt/etc/live/$HOSTNAME/fullchain.pem ./certs/fullchain.pem&&
cp ./letsencrypt/etc/live/$HOSTNAME/privkey.pem ./certs/privkey.pem &&
docker run  --network abantecart --name abantecart \
  --restart always  -p 80:80 -p 443:443 \
  -v "$PWD/certs":/etc/ssl/apache2 \
  ameseguer/abantecart
