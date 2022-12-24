#!/usr/bin/env bash

# update instance packages
sudo apt update -y
sudo apt upgrade -y
# install mysql and sysbench
sudo apt-get install mysql-server -y
sudo apt-get install sysbench -y
# set sakila database
sudo wget "https://downloads.mysql.com/docs/sakila-db.tar.gz"
tar xvzf sakila-db.tar.gz
sudo mysql -u root --password="" < sakila_source.sql
# set up the MySQL connection parameters
MYSQL_USER=root
MYSQL_PASSWORD=root
MYSQL_DB=sakila
THREADS=4
# run the sysbench test
sudo sysbench oltp_read_write --db-driver=mysql --table-size=1000 --mysql-user=$MYSQL_USER --mysql-db=$MYSQL_DB prepare
sudo sysbench oltp_read_write --db-driver=mysql --table-size=1000 --mysql-user=$MYSQL_USER --mysql-db=$MYSQL_DB --num-threads=$THREADS --max-time=60 run > standalone_benchmark.txt
sudo sysbench oltp_read_write --db-driver=mysql --table-size=1000 --mysql-user=$MYSQL_USER --mysql-db=$MYSQL_DB cleanup