#!/bin/bash


function finish {
  kill -9 `pidof gearmand`
}

trap finish SIGTERM SIGKILL

start_ts=$(date +%s)
while :
    do
        (is_dir /var/www/application) >/dev/null 2>&1
        result=$?
        end_ts=$(date +%s)
        if [[ $result -eq 0 ]]; then
            echo "/var/www/application is available after $((end_ts - start_ts)) seconds"
            break
        fi
        echo "/var/www/application is not available after $((end_ts - start_ts)) seconds"
        sleep 1
    done

echo "Running composer"

exec composer.phar install
