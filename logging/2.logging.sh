#!/bin/bash

echo "Настройка имени машины"
hostnamectl set-hostname otus-logging

apt-get update

#echo "Установка prometheus-node-exporter"
#apt install prometheus-node-exporter -y

echo "Установка default-jdk"
apt install default-jdk -y

echo "Установка elasticsearch"
dpkg -i "/home/ad/elasticsearch-8.9.1-amd64.deb"

echo "Установка kibana"
dpkg -i "/home/ad/kibana-8.9.1-amd64.deb"

echo "Установка logstash"
dpkg -i "/home/ad/logstash-8.9.1-amd64.deb"

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

echo "Перезагрузка"
reboot