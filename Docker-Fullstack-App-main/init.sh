#!/bin/bash

# bind-address to 0.0.0.0 for remote client access
sed -i 's/^bind-address\s*=.*$/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# start MariaDB
service mariadb start

# wait for MariaDB running
until mysqladmin ping &>/dev/null; do
  echo "Waiting for MariaDB..."
  sleep 1
done

# create database and user
mysql -e "CREATE USER IF NOT EXISTS 'user1'@'%' IDENTIFIED BY 'secret';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'user1'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# configurate Apache
sed -i 's/DirectoryIndex .*/DirectoryIndex index.php index.html/' /etc/apache2/mods-enabled/dir.conf

# restart Apache
service apache2 restart