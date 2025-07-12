#!/bin/bash

DB_NAME="otus"

echo "Пул бэкапа из репозитория"
cd /home/ad/otus
git pull


echo "Удаление базы данных"
mysql -uroot -e "DROP DATABASE IF EXISTS $DB_NAME;"

echo "Создание базы данных"
mysql -uroot -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

echo "Восстановление базы данных"
mysql -uroot otus < /home/ad/otus/mysql/backup.sql

echo "Восстановление базы данных успешно завершено"