# CERTIFCATE
sudo openssl dhparam -out /etc/nginx/dhparam.pem 1024
sudo mkdir -p /var/www/_letsencrypt
sudo chown nginx /var/www/_letsencrypt

cd  /home/ec2-user/infra
source .env

sudo sed -i -r 's/(listen .*443)/\1; #/g; s/(ssl_(certificate|certificate_key|trusted_certificate) )/#;#\1/g; s/(server \{)/\1\n    ssl off;/g' /etc/nginx/sites-available/app.audiomind.com.br.conf /etc/nginx/sites-available/audiomind.com.br.conf /etc/nginx/sites-available/api.audiomind.com.br.conf
sudo nginx -t && sudo systemctl reload nginx

sudo certbot certonly --webroot -d app.audiomind.com.br --email roger@rogerjunior.com -w /var/www/_letsencrypt -n --agree-tos --force-renewal
sudo certbot certonly --webroot -d audiomind.com.br --email roger@rogerjunior.com -w /var/www/_letsencrypt -n --agree-tos --force-renewal
sudo certbot certonly --webroot -d api.audiomind.com.br --email roger@rogerjunior.com -w /var/www/_letsencrypt -n --agree-tos --force-renewal

sed -i -r -z 's/#?; ?#//g; s/(server \{)\n    ssl off;/\1/g' /etc/nginx/sites-available/app.audiomind.com.br.conf /etc/nginx/sites-available/audiomind.com.br.conf /etc/nginx/sites-available/api.audiomind.com.br.conf
sudo nginx -t && sudo systemctl reload nginx

sudo echo -e '#!/bin/bash\nnginx -t && systemctl reload nginx' | sudo tee /etc/letsencrypt/renewal-hooks/post/nginx-reload.sh
sudo chmod a+x /etc/letsencrypt/renewal-hooks/post/nginx-reload.sh

sudo nginx -t && sudo systemctl reload nginx