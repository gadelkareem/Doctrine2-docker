#!/bin/bash


function finish {
  kill -9 `pidof gearmand`
}

trap finish SIGTERM SIGKILL


DEFAULT_PORT=4730

PARAMS="--backlog=32 \
  --job-retries=0 \
  --listen=0.0.0.0 \
  --threads=4 \
  --worker-wakeup=0 \
  --log-file=none \
  --file-descriptors=65536 \
  --port=${GEARMAN_PORT:-$DEFAULT_PORT} \
  "

PARAMS="$PARAMS --queue-type=mysql --mysql-host=$MYSQL_HOST --mysql-user=$MYSQL_USER --mysql-password=$MYSQL_PASSWORD --mysql-db=$MYSQL_DB"

start_ts=$(date +%s)
while :
    do
#        (echo > /dev/tcp/$MYSQL_HOST/3306) >/dev/null 2>&1
        (printf exit | mysql -s -N -h $MYSQL_HOST -P 3306 -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DB) >/dev/null 2>&1
        result=$?
        end_ts=$(date +%s)
        if [[ $result -eq 0 ]]; then
            echo "$MYSQL_HOST:3306 is available after $((end_ts - start_ts)) seconds"
            break
        fi
        echo "$MYSQL_HOST:3306 is not available after $((end_ts - start_ts)) seconds"
        sleep 1
    done

until mysql -s -N -h $MYSQL_HOST -P 3306 -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DB; do
  >&2 echo "MySQL is unavailable - sleeping"
  sleep 1
done

echo "Starting gearman job server with params: $PARAMS"

exec gearmand $PARAMS
