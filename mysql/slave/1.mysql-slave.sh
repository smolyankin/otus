#!/bin/bash

echo "Копирование конфигурации mysql"
cp /home/ad/otus/mysql/slave/mysqld.cnf /etc/mysql/mysql.conf.d

echo "Перезапуск mysql"
systemctl restart mysql

echo "Настройка репликации"
mysql -uroot -e "STOP REPLICA; CHANGE REPLICATION SOURCE TO SOURCE_HOST='192.168.0.101', SOURCE_USER='repl', SOURCE_PASSWORD='repl', SOURCE_AUTO_POSITION=1, GET_SOURCE_PUBLIC_KEY=1; START REPLICA;"

echo "Перезапуск mysql"
systemctl restart mysql