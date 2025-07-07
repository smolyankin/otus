#!/bin/bash

echo "Настройка имени машины"
hostnamectl set-hostname otus-mysql-slave

echo "Установка MySQL"
apt install mysql-server-8.0 -y

echo "Запуск MySQL"
systemctl start mysql

echo "Настройка сети"
cp ./otus/2.mysql-slave/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
chmod 600 /etc/netplan/01-netcfg.yaml
netplan apply

echo "Перезагрузка"
reboot