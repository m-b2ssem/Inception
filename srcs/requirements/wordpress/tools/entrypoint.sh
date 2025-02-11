#!/usr/bin/env bash

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)



if [ -f "/var/www/html/wp-config.php" ]; then
	echo "WordPress is already installed";
	exec "$@";
	exit 0;
fi

echo "Installing WordPress"
if [ ! -d "/usr/local/bin/wp/" ]; then
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
fi

if [ ! -d "/var/www/html" ]; then
    mkdir -p /var/www/html
fi

cd /var/www/html
rm -rf /var/www/html/*

wp core download --allow-root

wp config create	--dbname=$MYSQL_DATABASE \
					--dbuser=$MYSQL_USER \
					--dbpass=$MYSQL_PASSWORD \
					--dbhost=mariadb:3306 \
					--path='/var/www/html' \
					--allow-root 

wp core install		--url=$DOMAIN_NAME \
					--title=$LOGIN \
					--admin_user=$WP_ADMIN_USERNAME \
					--admin_password=$WP_ADMIN_PASSWORD \
					--admin_email=$WP_ADMIN_EMAIL \
					--allow-root

wp user create      $WP_USER_USERNAME $WP_USER_EMAIL \
                    --user_pass=$WP_USER_PASSWORD \
                    --role=subscriber \
                    --allow-root


exec "$@"