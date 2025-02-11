#!/bin/sh
set -e
FTP_PASSWORD=$(cat /run/secrets/ftp_password)


if [ -z "$FTP_USER" ] || [ -z "$FTP_PASSWORD" ]; then
  echo "ERROR: FTP_USER or FTP_PASSWORD environment variables are not set."
  exit 1
fi

service vsftpd start

useradd -m $FTP_USER

echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

chown -R $FTP_USER:$FTP_USER "/home/$FTP_USER"

# Whitelist the user in vsftpd
echo "$FTP_USER" >> /etc/vsftpd.userlist

service vsftpd stop

exec /usr/sbin/vsftpd /etc/vsftpd.conf
