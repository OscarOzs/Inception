FROM debian:buster

ARG MYSQL_DB_NAME
ARG MYSQL_DB_ADMIN
ARG MYSQL_DB_ADMIN_PASSWORD
ARG	MYSQL_DB_USER_PASSWORD
ARG MYSQL_DB_USER
ARG MYSQL_ROOT_PASSWORD

# installation
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y mariadb-server
RUN apt-get install -y mariadb-client
# RUN apt-get install -y procps

# setup directory
# RUN mkdir -p /var/run/mysqld
# RUN mkdir -p /var/lib/mysql
# RUN chown mysql:mysql /var/run/mysqld/
# RUN chmod -R 755 /var/run/mysqld/
# RUN chown mysql:mysql /var/lib/mysql/
# RUN chmod -R 755 /var/lib/mysql/


# copy configuration file to container
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

RUN			mysql_install_db --datadir=/var/lib/mysql --user=mysql

RUN		service mysql start	&& \
		echo "CREATE DATABASE $MYSQL_DB_NAME;" | mysql -u root && \
		echo "CREATE USER '$MYSQL_DB_ADMIN'@'*';" | mysql -u root && \
		echo "SET password FOR '$MYSQL_DB_ADMIN'@'*' = password('$MYSQL_DB_ADMIN_PASSWORD');" | mysql -u root && \
		echo "CREATE USER '$MYSQL_DB_USER'@'*';" | mysql -u root && \
		echo "SET password FOR '$MYSQL_DB_USER'@'*' = password('$MYSQL_DB_USER_PASSWORD');" | mysql -u root && \
		echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_DB_ADMIN'@'*' WITH GRANT OPTION;" | mysql -u root && \
		echo "GRANT ALL ON '$MYSQL_DB_NAME'.* to '$MYSQL_DB_ADMIN'@'*' IDENTIFIED BY '$MYSQL_DB_ADMIN_PASSWORD';" && \
		echo "SELECT host FROM mysql.user WHERE user = '$MYSQL_DB_ADMIN';"  | mysql -u root  && \
		echo "CREATE USER '$MYSQL_DB_ADMIN'@'%' IDENTIFIED BY '$MYSQL_DB_ADMIN_PASSWORD';" | mysql -u root && \
		echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_DB_ADMIN'@'%';" | mysql -u root && \
		echo "FLUSH PRIVILEGES;" | mysql -u root

# expose 3306 port to be accessible from other containers
EXPOSE 3306

CMD ["mysqld"]
