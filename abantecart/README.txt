AbanteCart + LetsEncrypt on Docker
ameseguer@akamai.com

These scripts create a unmanaged AbanteCart deployment. It is meant for training purposes and not for production.

Running the scripts with root permissions is necesary since , by default certbot creates the certificates using uid=0.

####Installing####

git clone https://github.com/ameseguer/gss-labs
cd gss-labs/abante
sudo sh ./install.sh

####Uninstalling####

cd gss-labs/abante
sudo sh ./uninstall.sh
