# INITIALIZE (USE source .env | bash 02-init.sh)
cd $HOME/infra
source .env
docker-compose up -d

echo "NGINX KILL"
sudo pkill -f nginx