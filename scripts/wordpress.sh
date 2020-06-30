#! bin/bash

ip=$(hostname -I | cut -f1 -d' ')
wordpress_conf="/etc/apache2/sites-available/wordpress.conf"

apt update -y
apt upgrade -y

apt install apache2 -y

systemctl restart apache2.service
systemctl enable apache2.service

apt-get install mysql-server -y

systemctl restart mysql.service
systemctl enable mysql.service

apt-get install php libapache2-mod-php php-mysql -y

apt-get install wordpress -y

touch $wordpress_conf
chmod 777 $wordpress_conf

sh -c "echo  'Alias /blog /usr/share/wordpress
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
</Directory>' >> /etc/apache2/sites-available/wordpress.conf"

a2ensite wordpress
a2enmod rewrite
service apache2 reload

#setting up database

mysql -u root <<MYSQL
CREATE DATABASE wordpress;
CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES
ON wordpress.*
TO wordpress@localhost
IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
quit
MYSQL

touch /etc/wordpress/config-$ip.php

printf "
<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'wordpress');
define('DB_PASSWORD', 'password');
define('DB_HOST', 'localhost');
define('DB_COLLATE', 'utf8_general_ci');
define('WP_CONTENT_DIR', '/usr/share/wordpress/wp-content');
?>"  >> /etc/wordpress/config-$ip.php

service mysql start
systemctl reload apache2
systemctl restart apache2
