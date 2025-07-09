#!/bin/bash

echo "Копирование настроек nginx/nginx.conf"
cp /home/ad/otus/front/nginx.conf /etc/nginx/nginx.conf
#rm -f /etc/nginx/sites-enabled/*
echo "Копирование настроек nginx/sites-enabled/default"
cp /home/ad/otus/front/default /etc/nginx/sites-enabled/default

echo "Перезапуск nginx"
systemctl restart nginx
systemctl status nginx