#!/bin/bash

echo "Настройка имени машины"
hostnamectl set-hostname otus-front

echo "Установка nginx"
apt install nginx -y

echo "Запуск nginx"
systemctl start nginx

echo "Настройка сети"
cp /home/ad/otus/front/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
chmod 600 /etc/netplan/01-netcfg.yaml
netplan apply

echo "Перезагрузка"
reboot