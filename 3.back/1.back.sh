#!/bin/bash

PUBLISH_DIR="/var/www"
SERVICE_NAME="otus-api.service"

cd ./api

dotnet restore
dotnet build -c Release --no-restore
dotnet publish -c Release -o $PUBLISH_DIR --runtime linux-x64 --self-contained false

# Настройка прав для службы
sudo chown -R www-data:www-data $PUBLISH_DIR
sudo chmod 755 $PUBLISH_DIR

cd ..
cp otus-api.service /etc/systemd/system/otus-api.service

systemctl enable $SERVICE_NAME
systemctl start $SERVICE_NAME
systemctl restart prometheus-node-exporter
