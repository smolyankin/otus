#!/bin/bash

echo "Остановка репликации"
mysql -uroot -e "STOP REPLICA;"

echo "Бэкап БД otus"
mysqldump -uroot -e --databases otus > /home/ad/otus/mysql/backup.sql

echo "Пуш бэкапа в репозиторий"
git config --global user.email 'zibo99@gmail.com'
git config --global user.name 'smolyankin'
cd /home/ad/otus
git add . && git commit -m 'Database backup' && git push origin main

echo "Возобновление репликации"
mysql -uroot -e "START REPLICA;"

echo "Создание бэкапа базы данных успешно завершено"