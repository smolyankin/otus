#!/bin/bash

echo "Настройка имени машины"
hostnamectl set-hostname otus-logging

echo "Настройка сети"
cp /home/ad/otus/logging/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
chmod 600 /etc/netplan/01-netcfg.yaml
netplan apply

echo "Перезагрузка"
reboot