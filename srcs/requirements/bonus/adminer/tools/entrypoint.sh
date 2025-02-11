#!bin/sh

if [ ! -d /var/www/html/adminer ]; then
	mkdir /var/www/html/adminer
fi

if [ ! -f /var/www/html/adminer/index.php ]; then
	cp /home/adminer/index.php /var/www/html/adminer/index.php
fi


exec "$@"