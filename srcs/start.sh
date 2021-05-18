if [ "$AUTOINDEX" = "off" ] ;
then cp /srcs/defaultOFF /etc/nginx/sites-available/default 
else cp /srcs/default /etc/nginx/sites-available/default 
	rm /var/www/html/index.nginx-debian.html
fi

service nginx start
service mysql start
service php7.3-fpm start

echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';" | mysql -u root --skip-password

bash
