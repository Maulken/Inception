#!/bin/sh

echo "Installing database..."


echo "Starting temp server"
/usr/bin/mysqld --user=mysql &
MARIADB_PID=$?


echo "Mariadb is starting..."
mariadb-check -A
STATUS=$?
while [[ $STATUS -ne 0 ]]
do
	mariadb-check -A
	STATUS=$?
	sleep 1
done

echo "Creating user and database"
<< EOF mariadb
DROP USER IF EXISTS $DB_USER@'%';
CREATE USER $DB_USER@'%' IDENTIFIED BY "$DB_PASSWORD";
DROP DATABASE IF EXISTS $DB_NAME;
CREATE DATABASE $DB_NAME;
GRANT ALL PRIVILEGES on $DB_NAME.* to $DB_USER@'%';
FLUSH PRIVILEGES;
EOF


echo "Stoping temp server"
kill $MARIADB_PID
wait $MARIADB_PID

echo "Installation complete"

exit 0
