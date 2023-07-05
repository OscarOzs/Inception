FROM debian:buster

# installation
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y mariadb-server
RUN apt-get install -y mariadb-client
RUN apt-get install -y procps

# setup directory
RUN mkdir -p /var/run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown mysql:mysql /var/run/mysqld/
RUN chmod -R 755 /var/run/mysqld/
RUN chown mysql:mysql /var/lib/mysql/
RUN chmod -R 755 /var/lib/mysql/

# expose 3306 port to be accessible from other containers
EXPOSE 3306

# copy and make dbscript.sh executable in container
COPY ./tools/dbscript.sh ./
RUN chmod +x ./dbscript.sh

# copy configuration file to container
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

# exec database script when container start
ENTRYPOINT ["bash", "./dbscript.sh"]
