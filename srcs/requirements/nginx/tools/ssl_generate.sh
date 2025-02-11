#!/usr/bin/env bash

set -e  # Exit on error

SSL_CERT="/etc/nginx/ssl/bmahdi.42.fr.crt"
SSL_KEY="/etc/nginx/ssl/bmahdi.42.fr.key"

if [ -f "$SSL_CERT" ]; then
  echo "SSL certificate already exists."
else
  echo "Generating SSL certificate..."
  mkdir -p /etc/nginx/ssl

  openssl req -x509 -nodes -days 365 \
    -newkey rsa:4096 \
    -keyout "$SSL_KEY" \
    -out "$SSL_CERT" \
    -subj "/C=AT/ST=Vienna/L=Vienna/O=42/CN=bmahdi.42.fr"

  chmod 600 "$SSL_KEY"
  chmod 644 "$SSL_CERT"

  echo "SSL certificate generated."
fi


nginx -g "daemon off;"
