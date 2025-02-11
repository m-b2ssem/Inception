FROM debian:bullseye


RUN apt-get update && apt-get install -y \
    nginx openssl && \
    rm -rf /var/lib/apt/lists/*

COPY conf/default.conf /etc/nginx/sites-available/default

EXPOSE 443

COPY ./tools/ssl_generate.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/ssl_generate.sh
ENTRYPOINT ["/usr/local/bin/ssl_generate.sh"]
