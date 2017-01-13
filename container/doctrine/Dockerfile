FROM gadelkareem/php7-gearman

ARG DEBIAN_FRONTEND=noninteractive

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin

WORKDIR /var/www/application

ADD ./start.sh /start.sh
RUN chmod +x /start.sh

CMD [ "/start.sh" ]

ENTRYPOINT /bin/bash