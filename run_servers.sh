#!/bin/bash
set -e

# Start MySQL in background
mysqld_safe --datadir=/var/lib/mysql &
MYSQL_PID=$!

# Wait until MySQL is ready
for i in {1..60}; do
  if mysqladmin ping --silent; then
    break
  fi
  sleep 1
done


python3 /app/backend/main.py &
node /app/frontend/server.js &
