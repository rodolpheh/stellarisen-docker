#!/bin/sh

MYSQL_HOST=${MYSQL_HOST:-127.0.0.1}
MYSQL_USER=${MYSQL_USER:-stellarisen}
MYSQL_DATABASE=${MYSQL_DATABASE:-stellarisen}
APP_FOLDER=${APP_FOLDER:-/var/www/stellarisen}

# Generating a random secret string for JWTs
printf "Generating application secret ...\n"
jwtsecret=$(pwgen -s 65 1 )

# Generation of .env config file.
envfile="${APP_FOLDER}/api/.env"
referenceenvfile="${APP_FOLDER}/api/.env.example"

if [ ! -f ${APP_FOLDER}/api/.env.example ]; then
    echo "Fatal error : reference config file not found."
    echo "Please clone git repository and try again"
    echo "Exiting..."
    exit 1
fi

# Reference for example file parsing
dbpwline="DB_PASSWORD=database_user_password_generated_during_deployment"
apisecretline="JWT_SECRET=a_strong_secret_generated_with_at_least_32_chars"
dbaddrline="DB_HOST=127.0.0.1"
dbdatabase="DB_DATABASE=stellarisen"
dbusername="DB_USERNAME=stellarisen"

# Deleting and creating environment file
if [ -f ${APP_FOLDER}/api/.env ]; then
    rm ${APP_FOLDER}/api/.env;
fi

touch ${APP_FOLDER}/api/.env

printf "Generating configuration file...\n"
IFS=''
while read line
do
    if [ x"$line" == x"$dbpwline" ]; then
        echo "DB_PASSWORD=${MYSQL_PASSWORD}" >> ${APP_FOLDER}/api/.env
    elif [ x"$line" == x"$apisecretline" ]; then
        echo "JWT_SECRET=${jwtsecret}" >> ${APP_FOLDER}/api/.env
    elif [ x"$line" == x"$dbaddrline" ]; then
        echo "DB_HOST=${MYSQL_HOST}" >> ${APP_FOLDER}/api/.env
    elif [ x"$line" == x"$dbdatabase" ]; then
        echo "DB_DATABASE=${MYSQL_DATABASE}" >> ${APP_FOLDER}/api/.env
    elif [ x"$line" == x"$dbaddrline" ]; then
        echo "DB_USERNAME=${MYSQL_USER}" >> ${APP_FOLDER}/api/.env
    else
        echo $line >> ${APP_FOLDER}/api/.env
    fi
done < ${APP_FOLDER}/api/.env.example

printf "Installing dependencies with composer\n"
$(cd ${APP_FOLDER}/api/ && composer install --ignore-platform-reqs --no-scripts);

printf "Setting owner on /var/www for php-fpm Docker (uid 33, gid 33)\n"
chown -R 33:33 /var/www

printf "All done !"