#!/bin/bash


start_ts=$(date +%s)
while :
    do
        (printf exit | mysql -s -N -h $MYSQL_HOST -P 3306 -u root -p$MYSQL_PASSWORD) >/dev/null 2>&1
        result=$?
        end_ts=$(date +%s)
        if [[ $result -eq 0 ]]; then
            echo "$MYSQL_HOST:3306 is available after $((end_ts - start_ts)) seconds"
            break
        fi
        echo "$MYSQL_HOST:3306 is not available after $((end_ts - start_ts)) seconds"
        sleep 1
    done

while :
    do
        (test -f /var/www/application/composer.json) >/dev/null 2>&1
        result=$?
        end_ts=$(date +%s)
        if [[ $result -eq 0 ]]; then
            echo "/var/www/application is available after $((end_ts - start_ts)) seconds"
            break
        fi
        echo "/var/www/application is not available after $((end_ts - start_ts)) seconds"
        sleep 1
    done

echo "Creating Database"
mysql -u root -p$MYSQL_PASSWORD -e "CREATE DATABASE $MYSQL_USER"
mysql -u root -p$MYSQL_PASSWORD -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -u root -p$MYSQL_PASSWORD -e "grant all privileges on $MYSQL_USER.* to '$MYSQL_USER'@'%'"
mysql -u root -p$MYSQL_PASSWORD -e "CREATE DATABASE doctrine_tests_tmp"
mysql -u root -p$MYSQL_PASSWORD -e "grant all privileges on doctrine_tests_tmp.* to '$MYSQL_USER'@'%'"
mysql -u root -p$MYSQL_PASSWORD -e "flush privileges"


echo "Running composer"
exec composer.phar update
