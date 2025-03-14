#!/bin/sh

echo "Creating directories"

if [ -d /var/lib/mysql ]
then
	chown -R mysql:mysql /var/lib/mysql
else
	mkdir -p /var/lib/mysql
	chown -R mysql:mysql /var/lib/mysql
fi

if [ -d /run/mysqld ]
then
	chown -R mysql:mysql /run/mysqld
else
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -f /var/lib/mysql/initialized ]
then
	echo "Initializing system database"
	mariadb-install-db --user=mysql --ldata=/var/lib/mysql

	/scripts/init-db.sh

	touch /var/lib/mysql/initialized
fi

exec /usr/bin/mysqld --user=mysql
