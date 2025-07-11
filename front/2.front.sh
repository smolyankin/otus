#!/bin/bash

echo "Установка filebeat"
dpkg -i "/home/ad/filebeat-8.9.1-amd64.deb"

echo "Копирование настроек filebeat"
cp /home/ad/otus/front/filebeat.yml /etc/filebeat/filebeat.yml

echo "Запуск filebeat"
systemctl start filebeat
systemctl enable filebeat

echo "Перезагрузка"
reboot