FROM debian:bullseye

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld /var/run/mysqld && \
    chown -R mysql:mysql /run/mysqld /var/run/mysqld && \
    chmod 777 /run/mysqld /var/run/mysqld

EXPOSE 3306

COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
