FROM debian:bullseye

RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install -y nginx \
                       php7.4-fpm \
                       php7.4-cli \
                       php7.4-mbstring \
                       php7.4-zip \
                       unzip \
                       wget && \
                    apt-get clean

RUN mkdir /home/file-manager
RUN wget -O /home/file-manager/index.php https://raw.githubusercontent.com/prasathmani/tinyfilemanager/master/tinyfilemanager.php
RUN sed -i "s|\$root_path = \$_SERVER\['DOCUMENT_ROOT'\];|\$root_path = '/var/www/html';|" /home/file-manager/index.php


COPY tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh


EXPOSE 8082


CMD ["/usr/local/bin/entrypoint.sh"]
