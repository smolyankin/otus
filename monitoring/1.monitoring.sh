#!/bin/bash

echo "Копирование настроек prometheus"
cp /home/ad/otus/monitoring/prometheus.yml /etc/prometheus/prometheus.yml

echo "Перезапуск prometheus"
systemctl daemon-reload
systemctl enable prometheus
systemctl restart prometheus

echo "Перезапуск grafana-server"
systemctl enable grafana-server
systemctl restart grafana-server