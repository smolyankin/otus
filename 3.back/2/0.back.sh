#!/bin/bash

echo "Настройка имени машины"
hostnamectl set-hostname otus-back

echo "Установка dotnet"
apt-get update
apt-get install aspnetcore-runtime-8.0 -y
echo "Установка prometheus-node-exporter"
apt install prometheus-node-exporter -y

#echo "Запуск prometheus-node-exporter"
#systemctl start prometheus-node-exporter

echo "Скачивание репозитория"
cd /home/ad
git clone https://github.com/smolyankin/otus.git

echo "Настройка сети"
cp /home/ad/otus/3.back/2/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
chmod 600 /etc/netplan/01-netcfg.yaml
netplan apply

echo "Перезагрузка"
reboot