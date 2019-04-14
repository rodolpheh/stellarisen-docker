FROM composer:latest

RUN apk add --no-cache pwgen

RUN mkdir /var/www/stellarisen
WORKDIR /var/www/stellarisen

ENV APP_FOLDER /var/www/stellarisen

COPY ./stellarisen .
COPY ./composer/compose.sh /

ENTRYPOINT [ "/compose.sh" ]

