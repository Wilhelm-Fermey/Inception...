#!/bin/bash

if [ ! -f "/var/www/html/wordpress/index.php" ]; then
	wp core download --allow-root
	wp config create --dbname=$DB_NAME --dbuser=$DB_USER_NAME --dbpass=$DB_USER_PWD --dbhost=$DB_SERVER --dbcharset="utf8"  --allow-root
	wp core install --url=wfermey.42.fr --title=$WP_TITLE --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email   --allow-root
	wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD   --allow-root
	wp theme install inspiro --activate --allow-root

    # enable redis cache
    sed -i "40i define( 'WP_REDIS_HOST', '$REDIS_HOST' );"      wp-config.php
    sed -i "41i define( 'WP_REDIS_PORT', 6379 );"               wp-config.php
    sed -i "42i define( 'WP_REDIS_TIMEOUT', 1 );"               wp-config.php
    sed -i "43i define( 'WP_REDIS_READ_TIMEOUT', 1 );"          wp-config.php
    sed -i "44i define( 'WP_REDIS_DATABASE', 0 );\n"            wp-config.php

    wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
	wp redis enable --allow-root

fi

exec php-fpm7.3 -F
