#!/bin/bash

echo "Настройка имени машины"
hostnamectl set-hostname otus-monitoring

apt-get update

echo "Установка prometheus-node-exporter"
apt install prometheus-node-exporter -y

echo "Установка prometheus"
apt-get install prometheus -y

echo "Скачивание grafana"
apt-get install -y adduser libfontconfig1 musl
wget https://dl.grafana.com/oss/release/grafana_11.6.3_amd64.deb
echo "Установка grafana"
dpkg -i grafana_11.6.3_amd64.deb

echo "Запуск prometheus"
systemctl start prometheus

echo "Запуск grafana-server"
systemctl start grafana-server

echo "Настройка сети"
cp /home/ad/otus/monitoring/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
chmod 600 /etc/netplan/01-netcfg.yaml
netplan apply

echo "Перезагрузка"
reboot