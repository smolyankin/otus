#!/bin/bash

echo "Копирование настроек elasticsearch"
cp /home/ad/otus/logging/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

echo "Копирование настроек kibana"
cp /home/ad/otus/logging/kibana.yml /etc/kibana/kibana.yml

echo "Копирование настроек logstash"
cp /home/ad/otus/logging/logstash.yml /etc/logstash/logstash.yml
cp /home/ad/otus/logging/logstash-nginx-es.conf /etc/logstash/conf.d/logstash-nginx-es.conf

echo "Перезапуск elasticsearch"
systemctl restart elasticsearch

echo "Перезапуск kibana"
systemctl restart kibana

echo "Перезапуск logstash"
systemctl restart logstash