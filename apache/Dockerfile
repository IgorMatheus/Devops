FROM ubuntu:22.04

RUN apt update -y

RUN apt install -y vim \
curl \
apache2

RUN apachectl -k restart

CMD ["apachectl", "-D", "FOREGROUND"]

EXPOSE 80
