#!/usr/bin/env bash
set -e

DB_DIR="/var/lib/mysql"
DB_NAME="${MYSQL_DATABASE}"
DB_USER="${MYSQL_USER}"
DB_PASS=$(cat /run/secrets/db_password)
ROOT_PASS=$(cat /run/secrets/db_root_password)

if [ -d "${DB_DIR}/${DB_NAME}" ] && [ -n "$(ls -A ${DB_DIR} 2>/dev/null)" ]; then
    echo "Database '${DB_NAME}' is already initialized."
else
    echo "No existing database found. Initializing..."

    # Initialize the MariaDB data directory
    mysql_install_db --user=mysql --datadir="${DB_DIR}"

    echo "Starting MariaDB for setup..."
    service mariadb start

    echo "Running mysql_upgrade to ensure system tables are up to date..."
    mysql_upgrade --force


    mariadb --user=root <<SQL
        -- 1. Set root password (only if you provided one)
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';

        -- 2. Remove anonymous users
        DELETE FROM mysql.user WHERE User='';

        -- 3. Remove the test database and access to it
        DROP DATABASE IF EXISTS test;
        DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';

        -- Reload privileges
        FLUSH PRIVILEGES;
SQL

    # Create the specified database and user, granting privileges
    mariadb --user=root --password="${ROOT_PASS}" <<SQL
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
SQL

    echo "Stopping MariaDB after initial setup..."
    service mariadb stop
fi

echo "Starting MariaDB server in foreground..."
exec mysqld --bind-address=0.0.0.0
