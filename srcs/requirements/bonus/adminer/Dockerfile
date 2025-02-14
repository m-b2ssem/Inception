FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php \
	php-cli \
	php-mbstring \
	php-xml \
	php-mysql \
	wget && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/adminer
RUN wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" -O /home/adminer/index.php


COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
