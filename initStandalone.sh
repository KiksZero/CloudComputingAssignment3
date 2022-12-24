#!/usr/bin/env bash

# update instance packages
sudo apt update -y
sudo apt upgrade -y
# install mysql and sysbench
sudo apt-get install mysql-server -y
sudo apt-get install sysbench -y
su ubuntu
# set sakila database
sudo curl -o sakila.tar.gz "https://downloads.mysql.com/docs/sakila-db.tar.gz"
tar xvzf sakila.tar.gz
sudo mysql -u root --password=""
SOURCE sakila-db/sakila-schema.sql;
SOURCE sakila-db/sakila-data.sql;
USE sakila;
exit
# set up the MySQL connection parameters
MYSQL_USER=root
MYSQL_PASSWORD=root
MYSQL_DB=sakila
THREADS=4
# run the sysbench test
sysbench --test=oltp --db-driver=mysql --mysql-user=$MYSQL_USER --mysql-password=$MYSQL_PASSWORD --mysql-db=$MYSQL_DB --oltp-table-size=1000 --oltp-tables-count=4 --num-threads=$THREADS --max-time=60 run
