FROM debian:bullseye

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/vsftpd.conf /etc/vsftpd.conf

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
