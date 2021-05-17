FROM debian:buster

MAINTAINER asebrech <asebrech@student.42nice.fr>

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get install openssl

COPY srcs/start.sh ./
COPY srcs/nginx_config ./

