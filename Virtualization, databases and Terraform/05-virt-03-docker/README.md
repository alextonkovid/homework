# Домашнее задание к занятию "3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

## Задача 1

Сценарий выполения задачи:

* создайте свой репозиторий на https://hub.docker.com;
* выберете любой образ, который содержит веб-сервер Nginx;
* создайте свой fork образа;
* реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:

```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```

Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username\_repo.

`docker push kofeinua/netology-nginx-edited:tagname`

## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

* Высоконагруженное монолитное java веб-приложение;

```
физическая машина

для такого вида приложений стоит использовать физичскую машину так как она обеспечит максимальную производительность
```

* Nodejs веб-приложение;

```
Docker контейнер или виртуальная машина

в зависимости от нагрузки. Можно запустить приложение в контейнере если она малая, а если нагрузка на сервер будет больше то стоит использовать виртуальную машину для лучшей производительности.
```

* Мобильное приложение c версиями для Android и iOS;

```
виртуальная машина

здесь я бы использовал кластер из виртуальных машин. Такое решения легко позволяет делать репликации и выкатывать релизы.
```

* Шина данных на базе Apache Kafka;

```
виртуальная машина,физическая машина

Если количество запросов небольшое можно начать с кластера контейнеров, а если есть большая нагрузка на сервер то лучше виртуальные машины.
```

* Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;

```
виртуальная машина, отказоустойчивость решается на уровне кластера, kibana и logstash я бы использовал в Docker.
```

* Мониторинг-стек на базе Prometheus и Grafana;

```
виртуальная машина, Docker контейнер
Системы можно развернуть в docker это бысто и можно масштабировать при необходимости до виртуальной машины.
```

* MongoDB, как основное хранилище данных для java-приложения;

```
физическая машина,виртуальная машина
Зависит от нагруженности сервиса при большой нагрузке лучше использовать физ машину.
```

* Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

```
Можно использовать и виртуальную машину и докер контейнер. Докер позволит масштабировать решение, так же удобно обновлять приложение без большого простоя сервиса.
Использование виртуальной машины позволит удобно администрировать сервис.
```

## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

```bash
root@vagrant:/home/data# docker ps
CONTAINER ID   IMAGE     COMMAND            CREATED         STATUS         PORTS     NAMES
5d7cd5420c8b   centos    "/bin/bash"        7 seconds ago   Up 6 seconds             quizzical_colden
f3a80fe60fd5   debian    "sleep infinity"   5 minutes ago   Up 5 minutes             intelligent_grothendieck

root@vagrant:/home/data# touch host_file
root@vagrant:/home/data# docker exec -it 5d7cd5420c8b /bin/bash
[root@5d7cd5420c8b /]# cd data
[root@5d7cd5420c8b data]# ls
debian_file  host_file
```
## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.
```
docker pull kofeinua/ansible:1.0
```