FROM alpine:3.17

RUN apk update && \
	apk upgrade && \
	apk add mariadb mariadb-client && \
	apk add dumb-init

RUN mariadb-install-db --datadir=/var/lib/mysql --auth-root-authentication-method=normal

RUN mkdir -p /run/mysqld /var/lib/mysql

COPY conf/my.cnf /etc/my.cnf
COPY tools/mariadb.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/mariadb.sh

EXPOSE 3306

ENTRYPOINT [ "/usr/bin/dumb-init", "--", "/usr/local/bin/mariadb.sh"]