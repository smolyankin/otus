#!/bin/bash

PUBLISH_DIR="/var/www"
SERVICE_NAME="otus-api.service"

cd /home/ad/otus/3.back/api

echo "dotnet restore"
dotnet restore
echo "dotnet build"
dotnet build -c Release --no-restore
echo "dotnet publish"
dotnet publish -c Release -o $PUBLISH_DIR --runtime linux-x64 --self-contained false

echo "Настройка прав для службы"
sudo chown -R www-data:www-data $PUBLISH_DIR
sudo chmod 755 $PUBLISH_DIR

echo "Копирование настроек сервиса"
cp /home/ad/otus/3.back/otus-api.service /etc/systemd/system/otus-api.service

echo "Настройка сети"
cp /home/ad/otus/3.back/2/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
chmod 600 /etc/netplan/01-netcfg.yaml
netplan apply

echo "Запуск сервисов"
systemctl enable $SERVICE_NAME
systemctl start $SERVICE_NAME
systemctl restart prometheus-node-exporter


