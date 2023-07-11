#!/bin/bash
# set -x


if [ -f /var/www/html/wordpress/wp-config.php ]; then
	echo "already exist"

else

cd /var/www/html/wordpress
wp core download --locale=en_US --allow-root

wp config create	--allow-root --dbname=${MYSQL_DB_NAME} \
			--dbuser=${MYSQL_DB_ADMIN} \
			--dbpass=${MYSQL_DB_ADMIN_PASSWORD} \
			--dbhost=${SQL_HOST} \
			--url=https://${DOMAIN_NAME};

wp core install	--allow-root \
			--url=https://${DOMAIN_NAME} \
			--title=${SITE_TITLE} \
			--admin_user=${ADMIN_USER} \
			--admin_password=${ADMIN_PASSWORD} \
			--admin_email=${ADMIN_EMAIL} \
			--skip-email

wp user create		--allow-root \
			${USER1_LOGIN} ${USER1_MAIL} \
			--role=author \
			--user_pass=${USER1_PASS} ;

wp cache flush --allow-root

# it provides an easy-to-use interface for creating custom contact forms and managing submissions, as well as supporting various anti-spam techniques
# wp plugin install contact-form-7 --activate

# # set the site language to English
# wp language core install en_US --activate

# # remove default themes and plugins
# wp theme delete twentynineteen twentytwenty
# wp plugin delete hello

# # set the permalink structure
# wp rewrite structure '/%postname%/'

fi

if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

# start the PHP FastCGI Process Manager (FPM) for PHP version 7.3 in the foreground
exec /usr/sbin/php-fpm7.3 -F -R
