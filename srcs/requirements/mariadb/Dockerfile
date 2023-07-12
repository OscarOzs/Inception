FROM debian:buster

ARG MYSQL_DB_NAME
ARG MYSQL_DB_ADMIN
ARG MYSQL_DB_ADMIN_PASSWORD
ARG	MYSQL_DB_PASSWORD
ARG MYSQL_DB_USER
ARG MYSQL_ROOT_PASSWORD

# installation
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y mariadb-server
RUN apt-get install -y mariadb-client

# expose 3306 port to be accessible from other containers
EXPOSE 3306

# copy configuration file to container
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf


RUN		service mysql start	&& \
	echo "CREATE DATABASE $MYSQL_DB_NAME;" | mysql -u root && \
    echo "SET password FOR 'root'@'localhost' = password('$MYSQL_ROOT_PASSWORD');" | mysql -u root && \
    echo "CREATE USER '${MYSQL_DB_USER}'@'*' IDENTIFIED BY '${MYSQL_DB_PASSWORD}';" | mysql -u root -p${MYSQL_ROOT_PASSWORD} && \
    echo "CREATE USER '${MYSQL_DB_ADMIN}'@'*' IDENTIFIED BY '${MYSQL_DB_ADMIN_PASSWORD}';" | mysql -u root -p${MYSQL_ROOT_PASSWORD} && \
    echo "GRANT ALL ON $MYSQL_DB_NAME.* TO '$MYSQL_DB_ADMIN'@'%' IDENTIFIED BY '$MYSQL_DB_ADMIN_PASSWORD';" | mysql -u root -p${MYSQL_ROOT_PASSWORD} && \
    echo "FLUSH PRIVILEGES;"

CMD ["mysqld"]