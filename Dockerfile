FROM debian:buster

ENV AUTOINDEX on

RUN apt-get update
RUN apt-get upgrade -y
RUN apt install -y nginx
RUN apt install -y vim
RUN apt install -y wget
RUN apt install -y mariadb-server 
RUN apt install -y php7.3 php7.3-fpm php7.3-mysql php7.3-cli php7.3-pdo php7.3-gd php7.3-mbstring

WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz
RUN rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzf latest.tar.gz
RUN rm -rf latest.tar.gz

COPY ./srcs/default /srcs/
COPY ./srcs/defaultOFF /srcs/
COPY ./srcs/config.inc.php phpmyadmin
COPY ./srcs/wp-config.php /var/www/html

RUN openssl req -nodes -x509 -days 365 -newkey rsa:2048 -subj "/C=FR/ST=France/L=Nice/O=42nice/OU=asebrech/CN=localhost" -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt

RUN chown -R www-data:www-data *
RUN chmod -R 755 /var/www/*

COPY ./srcs/start.sh ./
CMD bash start.sh
