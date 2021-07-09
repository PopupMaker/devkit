
ARG WP_VERSION
ARG PHP_VERSION=8.0
ARG PHP_SERVER=apache
ARG XDEBUG_ENABLED=0

FROM wordpress:${WP_VERSION:+$WP_VERSION-}${PHP_VERSION:+php$PHP_VERSION}${PHP_SERVER:+-$PHP_SERVER}

LABEL maintainer Code Atlantic <daniel@code-atlantic.com>

# Conditionally enable Xdebug
RUN if [ "$XDEBUG_ENABLED" = "1" ];  then pecl install "xdebug"  && docker-php-ext-enable xdebug ;  fi
# COPY ./docker/wordpress/setup-xdebug.sh /tmp/
# RUN if [ "$XDEBUG_ENABLED" = "1" ];  then chmod u+x /tmp/setup-xdebug.sh && /tmp/setup-xdebug.sh ;  fi

# Copy Apache custom configs (including xdebug)
COPY  ./docker/etc/apache/vhosts.conf /etc/apache2/sites-available/000-default.conf

# Copy PHP custom configs (including xdebug)
COPY ./docker/etc/php/custom.ini /usr/local/etc/php/conf.d/

VOLUME /var/www/html/
