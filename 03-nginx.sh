# "LOAD ENV VARS"
sudo systemctl stop nginx

cd  /home/ec2-user/infra
source .env
cd nginx/sites-available/
rm app.audiomind.com.br.conf api.audiomind.com.br.conf audiomind.com.br.conf -f
envsubst '${BACKEND_PORT},${FRONTEND_PORT},${HOME}' < _app.conf >   app.audiomind.com.br.conf
envsubst '${BACKEND_PORT},${FRONTEND_PORT},${HOME}' < _api.conf >   api.audiomind.com.br.conf
envsubst '${BACKEND_PORT},${FRONTEND_PORT},${HOME}' < _hotsite.conf > audiomind.com.br.conf

# "LOAD WEBS"
sudo cp -R /home/ec2-user/infra/nginx/* /etc/nginx

cd /etc/nginx/sites-available
sudo rm _api.conf _app.conf _hotsite.conf -f

cd  /home/ec2-user/infra/nginx/sites-available/
rm app.audiomind.com.br.conf api.audiomind.com.br.conf audiomind.com.br.conf -f

# "ENABLE WEBSITES"
cd /etc/nginx
mkdir -p sites-enabled
cd sites-enabled
sudo ln -sf ../sites-available/app.audiomind.com.br.conf  app.audiomind.com.br.conf  # # "Creates a symlink to the available websites"
sudo ln -sf ../sites-available/api.audiomind.com.br.conf  api.audiomind.com.br.conf  # # "Creates a symlink to the available websites"
sudo ln -sf ../sites-available/audiomind.com.br.conf  audiomind.com.br.conf  # # "Creates a symlink to the available websites"

# "START NGINX"
cd /etc/nginx
sudo systemctl start nginx

echo "NGINX restarted"