FROM ubuntu:xenial

ENV LANG C.UTF-8
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update  \
    && apt-get install -y software-properties-common  \
    && add-apt-repository -y ppa:ondrej/php   \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
    && apt-get update  \
    && apt-get -y install \
    php \
    php-cgi \
    php-cli \
    php-common \
    php-curl \
    php-dev \
    php-json \
    php-ldap \
    php-mysql \
    php-odbc \
    php-sqlite3 \
    php-xmlrpc \
    php-intl \
    php-mcrypt \
    php-mbstring \
    php-zip \
    php-gearman \
     && apt-get clean



