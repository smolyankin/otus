#!/bin/bash

API_USER="api_user"
API_PASS="1234"
REPL_PASS="repl"
DB_NAME="otus"

echo "Копирование конфигурации mysql"
cp /home/ad/otus/mysql/master/mysqld.cnf /etc/mysql/mysql.conf.d
echo "Перезапуск mysql"
systemctl restart mysql

echo "Создание пользователя репликации"
mysql -uroot -e "CREATE USER IF NOT EXISTS repl@'%' IDENTIFIED WITH 'caching_sha2_password' BY '$REPL_PASS'; FLUSH PRIVILEGES;"
mysql -uroot -e "GRANT REPLICATION SLAVE ON *.* TO repl@'%'; FLUSH PRIVILEGES;"

echo "Создание пользователя сервиса"
mysql -uroot -e "CREATE USER '$API_USER'@'%' IDENTIFIED BY '$API_PASS'; FLUSH PRIVILEGES;"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '$API_USER'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

echo "Создание БД и таблицы сервиса"
mysql -uroot -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -uroot -e "USE $DB_NAME; CREATE TABLE IF NOT EXISTS Requests (Id BIGINT AUTO_INCREMENT PRIMARY KEY, Ip VARCHAR(45) NOT NULL);"

echo "Конец"