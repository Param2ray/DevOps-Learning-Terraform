#!/bin/bash
set -e

# ---------- Change these ----------
DB_NAME="wordpress"
DB_USER="wpuser"
DB_PASS="CHANGE_ME"
DB_ROOT_PASS="CHANGE_ME"
# -------------------------------

export DEBIAN_FRONTEND=noninteractive

# 1) Update OS and install packages
apt-get update -y
apt-get upgrade -y

apt-get install -y apache2 mariadb-server php php-mysql libapache2-mod-php \
  php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip \
  unzip curl

# 2) Enable and start services
systemctl enable --now apache2
systemctl enable --now mariadb

# 3) Secure MariaDB (basic hardening)
mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

# 4) Create WordPress DB + user
mysql -u root -p"${DB_ROOT_PASS}" <<EOF
CREATE DATABASE ${DB_NAME} DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
EOF

# 5) Download and install WordPress files
cd /tmp
curl -LO https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz

rm -rf /var/www/html/*
cp -a /tmp/wordpress/. /var/www/html/

# 6) Configure wp-config.php
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/${DB_NAME}/" /var/www/html/wp-config.php
sed -i "s/username_here/${DB_USER}/" /var/www/html/wp-config.php
sed -i "s/password_here/${DB_PASS}/" /var/www/html/wp-config.php

# Add WordPress secret keys/salts
sed -i "/AUTH_KEY/s/put your unique phrase here/$(echo "$SALT_KEYS" | head -n 1 | sed 's/[\/&]/\\&/g')/" /var/www/html/wp-config.php
# Replace the whole salts block properly:

# 7) Permissions
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

# 8) Restart Apache
systemctl restart apache2