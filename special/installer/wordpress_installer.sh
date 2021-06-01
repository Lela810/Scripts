#!/bin/bash 


# Clear Current Screen
clear

# Check Session Status
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
elif [[ $EUID -eq 0 ]]; then
   echo -e "Session Running as \e[36mROOT\e[0m"
fi



echo ""
echo ""
echo "How is the Domain of the Website? xyz.xy (without www.):"
read domain
echo ""


apt update -y
apt install wordpress php libapache2-mod-php mysql-server php-mysql php-curl php-dom php-mbstring php-imagick php-zip -y

echo "<VirtualHost *:80>
    ServerName $domain
    Redirect permanent / https://www.$domain/
</VirtualHost>

<VirtualHost *:80>
    ServerName www.$domain
    DocumentRoot /usr/share/wordpress
    <Directory /usr/share/wordpress>
       Options FollowSymLinks
       AllowOverride Limit Options FileInfo
       DirectoryIndex index.php
       Order allow,deny
       Allow from all
    </Directory>
    <Directory /usr/share/wordpress/wp-content>
       Options FollowSymLinks
       Order allow,deny
       Allow from all
    </Directory>
</VirtualHost>" > /etc/apache2/sites-available/wordpress.conf


a2ensite wordpress
a2enmod rewrite
service apache2 reload

echo "CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS \"wordpress\"@\"localhost\" IDENTIFIED BY \"31Yxcvbnm\";
GRANT ALL PRIVILEGES ON wordpress.* TO "wordpress"@"localhost";
FLUSH PRIVILEGES;" > wordpress.sql

mysql -u root < wordpress.sql
rm wordpress.sql


cd /usr/share/
chown www-data:www-data  -R ./wordpress # Let Apache be owner
cd ./wordpress
chmod -R 755 *



echo "<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'wordpress');
define('DB_PASSWORD', '31Yxcvbnm');
define('DB_HOST', 'localhost');
define('DB_COLLATE', 'utf8_general_ci');
define('WP_CONTENT_DIR', '/usr/share/wordpress/wp-content');
define( 'WP_HOME', 'https://www.$domain' );
define( 'WP_SITEURL', 'https://www.$domain' );
?>" > /etc/wordpress/config-$domain.php

#Update
wget https://wordpress.org/wordpress-5.6.2.tar.gz 
tar -xf wordpress-5.6.2.tar.gz
rm -r /usr/share/wordpress/wp-includes
rm -r /usr/share/wordpress/wp-admin
cp -r ./wordpress/wp-admin /usr/share/wordpress/wp-admin
cp -r ./wordpress/wp-includes /usr/share/wordpress/wp-includes
cp -nr ./wordpress/wp-content/* /usr/share/wordpress/wp-content/*
cp ./wordpress/*.php /usr/share/wordpress/
cd /usr/share/
chown www-data:www-data  -R ./wordpress
cd ./wordpress
chmod -R 755 *
service apache2 restart


echo ""
echo ""
echo ""
echo "Wordpress installed!"
echo ""
echo "MySQL:"
echo "	User: wordpress"
echo "	Password: 31Yxcvbnm"
echo ""
echo "Add \"define('FS_METHOD','direct');\" to /usr/share/wordpress/wp-config.php"
echo ""
echo ""

