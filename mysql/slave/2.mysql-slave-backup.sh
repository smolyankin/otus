#!/bin/bash

echo "Остановка репликации"
mysql -uroot -e "STOP REPLICA;"

echo "Бэкап БД otus"
mysqldump -uroot -e --single-transaction --triggers --routines --events --set-gtid-purged=OFF --databases otus > /home/ad/backup.sql

echo "Возобновление репликации"
mysql -uroot -e "START REPLICA;"

echo "Создание бэкапа базы данных успешно завершено"