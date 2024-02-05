#!/bin/bash

set -x

while true; do
    if ! nc -z localhost 5432; then
        echo "PostgreSQL server is not responding, attempting to restart..."
        systemctl restart postgresql
    else
        result=$(psql -h localhost -d ord2_mainnet -U postgres -c "SELECT * from ord2_event_types;" 2>&1)
        if [ $? -ne 0 ]; then
            echo "Failed to execute psql command: $result, attempting to restart..."
            systemctl restart postgresql
        else
            echo "ord2 select sql command executed successfully:"
            echo "$result"
        fi
    fi
    sleep 10
done
