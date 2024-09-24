FROM php:8.3-apache

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apache2-utils \
        git \
        unzip && \
    rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

COPY etc/ssl/server.crt /etc/ssl/certs/
COPY etc/ssl/server.key /etc/ssl/private/
COPY etc/apache2/000-default.conf /etc/apache2/sites-available/
COPY etc/apache2/000-default-ssl.conf /etc/apache2/sites-available/

RUN a2enmod ssl
RUN a2ensite 000-default-ssl.conf
