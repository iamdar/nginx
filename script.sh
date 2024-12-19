#!/bin/bash

# Fix DNS
echo "nameserver 1.1.1.1" > /etc/resolv.conf

# Update
sudo apt update && sudo apt upgrade -y

# Check if git is installed
command -v git &> /dev/null && { echo "Git is already installed. Version: $(git --version)"; } || { echo "Git is not installed. Installing Git..."; sudo apt install -y git; }

# Check if nginx is installed
command -v nginx &> /dev/null && { echo "nginx is already installed. Version: $(nginx -v)"; } || { echo "nginx is not installed. Installing nginx..."; sudo apt install -y nginx; }
systemctl start nginx
systemctl enable nginx

# Setting the git config
cat << EOF > /home/vagrant/.gitconfig
[user]
	email = darvin.basilio@gmail.com
	name = Darvin Basilio
EOF

# Downloading my test website
mkdir /var/www/CheckmateChuckles
git clone https://github.com/iamdar/CheckmateChuckles.git /var/www/CheckmateChuckles

# Remove default configuration
unlink /etc/nginx/sites-enabled/default

# setting the conf
cat << EOF > /etc/nginx/conf.d/CheckmateChuckles.conf
server {
    listen 80 default_server;
    root /var/www/CheckmateChuckles;

    server_name CheckmateChuckles.local www.CheckmateChuckles.local;
    index index.html index.htm index.php;
}
EOF

# reload config
nginx -t
systemctl reload nginx


echo "This is accessible in your local computer via port 5000 http://localhost:5000"
