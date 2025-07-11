#!/bin/bash

echo "Настройка имени машины"
hostnamectl set-hostname otus-front

echo "Установка nginx"
apt install nginx -y

echo "Подготовка к установке filebeat"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
apt-get install apt-transport-https -y
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/9.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-9.x.list
apt-get update
echo "Установка filebeat"
apt-get install filebeat -y

echo "Запуск nginx"
systemctl start nginx

echo "Запуск filebeat"
systemctl start filebeat
systemctl enable filebeat

echo "Настройка сети"
cp /home/ad/otus/front/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
chmod 600 /etc/netplan/01-netcfg.yaml
netplan apply

echo "Перезагрузка"
reboot