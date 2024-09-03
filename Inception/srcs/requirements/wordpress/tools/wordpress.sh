#!/bin/sh

sleep 5
/usr/local/bin/wait-for-it.sh $MARIADB_HOST:$MARIADB_PORT --timeout=15

if [ ! -f /var/www/html/wp-config.php ]; then
  /usr/local/bin/wp core download --allow-root --path=/var/www/html --force
  /usr/local/bin/wp config create --allow-root --path=/var/www/html --dbhost=$MARIADB_HOST:$MARIADB_PORT --dbname=$MARIADB_NM --dbuser=$MARIADB_USER --dbpass=$MARIADB_PWD --force
  /usr/local/bin/wp core install --allow-root --path=/var/www/html --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email
  /usr/local/bin/wp user create --path=/var/www/html $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PWD --role=author
else
  echo "WordPress is already installed"
fi

/usr/sbin/php-fpm81 --nodaemonize