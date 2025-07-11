#!/bin/bash

echo "Настройка имени машины"
hostnamectl set-hostname otus-logging

#apt-get update

#echo "Установка prometheus-node-exporter"
#apt install prometheus-node-exporter -y


echo "Установка default-jdk"
apt install default-jdk -y

#echo "Добавление источника elasticsearch"
#curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | gpg --dearmor -o /usr/share/keyrings/elastic.gpg
#echo "deb [signed-by=/usr/share/keyrings/elastic.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list
#apt update
#echo "Установка elasticsearch"
#apt install elasticsearch -y

echo "Подготовка к установке elasticsearch"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
apt-get install apt-transport-https -y
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/9.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-9.x.list
apt-get update
echo "Установка elasticsearch"
apt-get install elasticsearch -y

#echo "Установка kibana"
#apt install kibana -y

echo "Установка kibana"
apt-get install kibana -y

echo "Установка logstash"
apt-get install logstash -y

systemctl daemon-reload

echo "Запуск elasticsearch"
systemctl start elasticsearch
systemctl enable elasticsearch

echo "Запуск kibana"
systemctl start kibana
systemctl enable kibana

echo "Запуск logstash"
systemctl start logstash
systemctl enable logstash

echo "Настройка сети"
cp /home/ad/otus/logging/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
chmod 600 /etc/netplan/01-netcfg.yaml
netplan apply

echo "Перезагрузка"
reboot