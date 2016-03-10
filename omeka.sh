#!/bin/bash

# Takes all of the instructions found here and runs them one at a time
# Link https://omeka.org/codex/Install_on_Ubuntu_using_Terminal

apt-get -y update && apt-get -y upgrade

# Install unzip and imagemagick
sudo apt-get -y install unzip imagemagick

# Set MySQL password
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password omeka"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password omeka"

# Install LAMP
sudo apt-get -y install lamp-server^
sudo apt-get -y install libapache2-mod-wsgi libapache2-mod-jk

# 1) Download and install Omeka 2.0 (be in the home directory)
cd ~
wget http://omeka.org/files/omeka-2.4.zip
unzip omeka-2.4.zip

# 2) Move the Omeka files to your web directory
sudo mv omeka-2.4/* /var/www/html/
sudo mv omeka-2.4/.htaccess /var/www/html/

# 3) Delete the old index.html file in www
sudo rm /var/www/html/index.html

# 4) Create a webuser and user
sudo groupadd webdev
sudo usermod -a -G webdev vagrant
cd /var
sudo chown -R root.webdev www/html 

# 5) Give permissions
sudo chmod 775 www/html
cd /var/www/html
find . -type d | sudo xargs chmod 775
find . -type f | sudo xargs chmod 664
find files -type d | sudo xargs chmod 777
find files -type f | sudo xargs chmod 666

# Create MySQL database
mysql --user=root --password=omeka < /vagrant/omeka.sql

# Configure db.ini with MySQL settings
cp /vagrant/db.ini /var/www/html/db.ini

# Enable mod_rewrite
sudo a2enmod rewrite

# Edit apache2.conf
cat <<EOF >> /etc/apache2/apache2.conf
<Directory /var/www/html>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Require all granted
</Directory>
EOF

# Edit default Apache site config
sed -i '2i <Directory /var/www/html> \n\t AllowOverride All \n</Directory>' /etc/apache2/sites-available/000-default.conf

# Restart Apache
sudo /etc/init.d/apache2 restart

# Done
printf "Open a web browser and go to your computer's IP/install/install.php to finish setting up Omeka!"