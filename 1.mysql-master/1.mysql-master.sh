#!/bin/bash

ROOT_PASS="1234"
REPL_PASS="repl"
DB_NAME="otus"

cp mysqld.cnf /etc/mysql/mysql.conf.d
systemctl restart mysql

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'caching_sha2_password' BY '$ROOT_PASS';"

mysql -u root -p $ROOT_PASS -e "CREATE USER IF NOT EXISTS repl@'%' IDENTIFIED WITH 'caching_sha2_password' BY '$REPL_PASS';"
mysql -u root -p $ROOT_PASS -e "GRANT REPLICATION SLAVE ON *.* TO repl@'%';"
mysql -u root -p $ROOT_PASS -e "FLUSH PRIVILEGES;"

mysql -u root -p $ROOT_PASS -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u root -p $ROOT_PASS -e "CREATE TABLE IF NOT EXISTS requests (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ip VARCHAR(45) NOT NULL);"
