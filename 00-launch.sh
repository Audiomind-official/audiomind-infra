# FIRST SETUP
sudo yum update -y
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chkconfig docker on
sudo yum install git -y

sudo yum update -y
sudo sudo amazon-linux-extras install epel -y
sudo amazon-linux-extras install nginx1 -y
sudo yum install python-certbot-apache -y
PATH=/usr/sbin/:$PATH

sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# CLONE REPOS
cd $HOME
git clone https://github.com/rgrjnr/audiomind-infra.git
git clone https://github.com/rgrjnr/audiomind-app.git
git clone https://github.com/rgrjnr/audiomind-backend.git
git clone https://github.com/rgrjnr/audiomind-site.git
mv audiomind-app frontend
mv audiomind-backend backend
mv audiomind-infra infra
mv audiomind-site hotsite

# "SETUP NGINX"
cd /home/ec2-user
sudo gpasswd -a nginx ec2-user
sudo chmod g+x /home/ec2-user && sudo chmod g+x /home/ec2-user/hotsite && sudo chmod g+x /home/ec2-user/backend

sudo rm /etc/nginx/sites-available/*