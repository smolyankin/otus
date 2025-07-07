#!/bin/bash

echo "Настройка имени машины"
hostnamectl set-hostname otus-back

echo "Установка dotnet"
apt-get update
apt-get install dotnet-sdk-8.0 -y
echo "Установка prometheus-node-exporter"
apt install prometheus-node-exporter -y

#echo "Запуск prometheus-node-exporter"
#systemctl start prometheus-node-exporter

echo "Настройка сети"
cp /home/ad/otus/3.back/1/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
chmod 600 /etc/netplan/01-netcfg.yaml
netplan apply

echo "Перезагрузка"
reboot