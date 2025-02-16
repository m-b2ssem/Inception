FROM debian:bullseye

RUN apt-get -y update && apt-get -y upgrade

RUN apt-get install -y wget \
            php7.4-fpm \
            php7.4-mysql \
            php7.4-redis \
            mariadb-client  && \
            rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d

RUN mkdir -p /run/php/

COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]  

CMD ["/usr/sbin/php-fpm7.4", "-F"]
