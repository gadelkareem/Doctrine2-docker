FROM gadelkareem/php7-gearman

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get -y install mysql-client \
    && apt-get clean

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin

WORKDIR /var/www/application
RUN echo 'alias dtests="/var/www/application/vendor/phpunit/phpunit/phpunit -c /var/mysql.docker.xml"' >> ~/.bashrc

ADD ./config/mysql.docker.xml /var/mysql.docker.xml


ADD ./start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT /start.sh && /bin/bash
