#!/bin/bash

ROOT_PASS="1234"
REPL_PASS="repl"
DB_NAME="otus"

cp ./otus/1.mysql-master/mysqld.cnf /etc/mysql/mysql.conf.d
systemctl restart mysql

mysql
use mysql;

ALTER USER 'root'@'localhost' IDENTIFIED WITH 'caching_sha2_password' BY '$ROOT_PASS';

CREATE USER IF NOT EXISTS repl@'%' IDENTIFIED WITH 'caching_sha2_password' BY '$REPL_PASS'; 
GRANT REPLICATION SLAVE ON *.* TO repl@'%';
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS $DB_NAME;

use $DB_NAME;

CREATE TABLE IF NOT EXISTS requests (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ip VARCHAR(45) NOT NULL);
	
exit;