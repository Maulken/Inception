FROM alpine:3.19

RUN apk update && \
	apk upgrade && \
	apk add --no-cache \
	mariadb	\
	mariadb-client	


ADD tools/init.sh /scripts/init.sh
ADD tools/init-db.sh /scripts/init-db.sh
ADD conf/mariadb.conf /etc/my.cnf.d/mariadb-server.cnf

RUN chmod +x /scripts/init.sh /scripts/init-db.sh
RUN mariadb-install-db

ENTRYPOINT ["/scripts/init.sh"]
