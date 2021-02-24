OpenCart + LetsEncrypt on Docker
ameseguer@akamai.com

These scripts create a unmanaged OpenCart deployment. It is meant for training purposes and not for production.

Running the scripts with root permissions is necesary since , by default certbot creates the certificates using uid=0.

####Installing####

git clone https://github.com/ameseguer/gss-labs
cd gss-labs/juiceshop-ssl
sudo sh ./install.sh

####Uninstalling####

cd gss-labs/juiceshop-ssl
sudo sh ./uninstall.sh
