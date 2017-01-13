FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get -y install gearman-tools gearman-job-server mysql-client \
    && apt-get clean

RUN mkdir -p /opt/gearman && chown gearman /opt/gearman

WORKDIR /opt/gearman
ADD ./start.sh /start.sh
RUN chmod +x /start.sh

CMD [ "/start.sh" ]

