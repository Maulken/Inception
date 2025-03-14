FROM alpine:3.19

RUN apk update && \
	apk upgrade && \
	apk add --no-cache \
		php-fpm \
		php-mysqli \
		php-phar \
		php-iconv \
		wget

RUN delgroup www-data
RUN adduser -D -H -s /sbin/nologin www-data
# Create directory for PHP-FPM socket
RUN mkdir -p /run/php
RUN chown -R www-data:www-data /run/php

# Create directory for service web file
RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

# Install WordPress
RUN wget https://wordpress.org/wordpress-6.4.3.tar.gz \
	&& tar -xvf wordpress-6.4.3.tar.gz --strip-components 1 \
	&& rm -rf wordpress-6.4.3.tar.gz

# Installer WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Install WP-CLI
# RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#	&& chmod +x wp-cli.phar \
#	&& mv wp-cli.phar /usr/local/bin/wp

# Redirect PHP-FPM logs
RUN ln -sf /dev/stdout /var/log/php7.4-fpm.log

#RUN sed -i 's|listen = /run/php/php-fpm.sock|listen = 9000|' /etc/php82/php-fpm.d/www.conf
COPY conf/www.conf /etc/php82/php-fpm.d/www.conf
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
