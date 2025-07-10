# Nginx, Backends, Databases, Monitoring and Logging

Ubuntu, MySQL, .NET, Nginx, Prometheus, Grafana

Предусловия:
- установлен VirtualBox
- скачен образ ubuntu-22.04.5-live-server-amd64.iso

## Сводная информация по виртуальным машинам
| Имя ПК            | IP Address | Назначение                     | Папка          | Порядок установки |Порты |
|-------------------|------------|--------------------------------|----------------|-------------------|-|
| otus-mysql-master | 192.168.0.101 | База данных                    | mysql/master | 1                 |3306 |
| otus-mysql-slave  | 192.168.0.102 | База данных (реплика)          | mysql/slave  | 2                 |3306 |
| otus-back-1         | 192.168.0.103 | Бекенд (dotnet api)            | back/1       | 3                 |8080 |
| otus-back-2        | 192.168.0.104 | Бекенд (dotnet api)            | back/2       | 4                 |8080 |
| otus-front        | 192.168.0.105 | Фронтенд (nginx балансировщик) | front        | 5                 |8080 |
| otus-monitoring   | 192.168.0.106 | Мониторинг                     | monitoring   | 6                 | |
| otus-logging      | 192.168.0.107 | Логирование                    | logging      | 7                 | |

## Общие предусловия для каждой виртуальной машины
- установлена Ubuntu с пользователем ad с паролем ad и включенным ssh
- настроен сетевой адаптер с типом Сетевой мост
- скачен репозиторий git clone https://github.com/smolyankin/otus

## MySQL master

### Предусловие
sudo bash /home/ad/otus/mysql/master/0.mysql-master.sh (меняет имя машины, устанавливает MySQL, настраивает сетевой интерфейс и перезагружает)

### Скрипт
sudo bash /home/ad/otus/mysql/master/1.mysql-master.sh.

### Файлы
- mysqld.cnf - настройки mysql

## MySQL slave

## Backend

### Предусловие
sudo bash /home/ad/otus/back/*/0.back.sh (меняет имя машины, устанавливает dotnet и prometheus-node-exporter, настраивает сетевой интерфейс и перезагружает) * - из соответствующих папок для соответствующих виртуальных машин (1 и 2)

### Скрипт
sudo bash /home/ad/otus/back/*/1.back.sh для каждой виртуальной машины backend из соответствующих папок.

### Файлы
- otus-api.service - конфигурация апи как службы
- /api - dotnet api. При запросе /otus сохраняет в БД otus в таблицу Requests IP адрес сервера и возвращает в ответе все записи из таблицы Requests.

## Front

### Предусловие
sudo bash /home/ad/otus/front/0.front.sh (меняет имя машины, устанавливает nginx, настраивает сетевой интерфейс и перезагружает)

### Скрипт
sudo bash /home/ad/otus/front/1.front.sh.

### Файлы
- nginx.conf - конфигурация nginx
- default - настройки балансировки и маршрутизации

