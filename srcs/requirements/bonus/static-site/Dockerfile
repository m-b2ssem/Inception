FROM debian:bullseye

RUN apt-get update \
    && apt-get -y upgrade \
    && rm -rf /var/lib/apt/lists/*

COPY ./html/resume.html /home/resume.html

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
	

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
