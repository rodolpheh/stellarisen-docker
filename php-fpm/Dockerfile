FROM php:fpm

RUN apt update \
 && apt install -y libxml2-dev libzip-dev zlib1g-dev \
 && docker-php-ext-install pdo pdo_mysql mysqli xml intl zip \
 && apt purge -y --auto-remove libxml2-dev libzip-dev zlib1g-dev \
 && apt clean