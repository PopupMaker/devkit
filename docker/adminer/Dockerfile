FROM adminer:latest

ARG ENV

USER root

# Install packages under Debian
RUN apk update && apk upgrade
RUN apk add --no-cache \
  git

RUN git clone https://github.com/pematon/adminer-theme.git /home/adminer/adminer-theme
RUN cp -a /home/adminer/adminer-theme/lib/. /var/www/html

# RUN git clone https://github.com/Niyko/Hydra-Dark-Theme-for-Adminer.git /home/adminer/hydra-theme
# RUN cp /home/adminer/hydra-theme/adminer.css /var/www/html/

# Copy PHP config files to /usr/local/etc/php/conf.d/
COPY ./etc/adminer/.  /var/www/html/
