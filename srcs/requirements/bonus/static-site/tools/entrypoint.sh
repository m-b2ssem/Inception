#!/bin/sh

if [ -f /var/www/html/resume.html ]; then
	echo "File resume.html exists."
	exit 0
else
	echo "File resume.html does not exist."
fi

mkdir -p /var/www/html/static-site

mv /home/resume.html /var/www/html/static-site

echo "File resume.html moved to /var/www/html/ folder."

exec "$@"
