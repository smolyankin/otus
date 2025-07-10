#!/bin/bash

echo "Копирование настроек prometheus"
cp /home/ad/otus/monitoring/prometheus.yml /etc/prometheus/prometheus.yml

echo "Перезапуск prometheus"
systemctl restart prometheus