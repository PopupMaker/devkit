
ARG WP_VERSION
ARG PHP_VERSION=8.0
ARG PHP_SERVER=apache

FROM wordpress:${WP_VERSION:+$WP_VERSION-}${PHP_VERSION:+php$PHP_VERSION}${PHP_SERVER:+-$PHP_SERVER}

LABEL maintainer Code Atlantic <daniel@code-atlantic.com>

# Arg must be set after FROM, or its not availble.
# https://stackoverflow.com/a/49654789
ARG XDEBUG_ENABLED
# Conditionally enable Xdebug
RUN if [ -n "$XDEBUG_ENABLED" ]; then pecl install xdebug && docker-php-ext-enable xdebug && service apache2 restart; fi

# Copy Apache custom configs (including xdebug)
COPY  ./etc/apache/vhosts.conf /etc/apache2/sites-available/000-default.conf

# Copy PHP custom configs (including xdebug)
COPY ./etc/php/custom.ini /usr/local/etc/php/conf.d/

VOLUME /var/www/html/
