#!/bin/bash

cp /home/ad/otus/5.front/nginx.conf /etc/nginx/nginx.conf
#rm -f /etc/nginx/sites-enabled/*
cp /home/ad/otus/5.front/default /etc/nginx/sites-enabled/default

systemctl restart nginx