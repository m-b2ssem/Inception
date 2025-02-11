#!/bin/bash

if [ -f /var/www/html/file-manager/index.php ]; then
    echo "Files exist."
else
    echo "Does not exist. Moving file manager..."
    mkdir -p /var/www/html/file-manager
    mv /home/file-manager/index.php /var/www/html/file-manager/index.php
fi

/
# Ensure correct permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

exec "$@"