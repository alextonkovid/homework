# Домашнее задание к занятию "5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
```bash
FROM centos:7

EXPOSE 9200 9300
RUN yum -y update && \
    yum -y install java-1.8.0-openjdk-headless && \
    yum clean all

RUN curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.12.0-linux-x86_64.tar.gz && \
    tar xvf elasticsearch-7.12.0-linux-x86_64.tar.gz && \
    mv elasticsearch-7.12.0 /var/lib/elasticsearch && \
    rm -f elasticsearch-7.12.0-linux-x86_64.tar.gz

COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

RUN mkdir -p /var/lib/elasticsearch && \
    chown -R 1000:1000 /var/lib/elasticsearch
RUN chmod -R 777 /var/lib/elasticsearch

USER 1000
ENV ES_HOME="/var/lib/elasticsearch" \
    ES_PATH_CONF="/var/lib/elasticsearch/config"
WORKDIR ${ES_HOME}
CMD ["/var/lib/elasticsearch/bin/elasticsearch"]

```
- ссылку на образ в репозитории dockerhub
```https://hub.docker.com/r/kofeinua/elasticsearch```

- ответ `elasticsearch` на запрос пути `/` в json виде

```bash
curl -X GET 'localhost:9200'
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "NrgayEB3Qbel2mjfd_KV9g",
  "version" : {
    "number" : "7.12.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "78722783c38caa25a70982b5b042074cde5d3b3a",
    "build_date" : "2021-03-18T06:17:15.410153305Z",
    "build_snapshot" : false,
    "lucene_version" : "8.8.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}

```


Подсказки:
- возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
- при некоторых проблемах вам поможет docker директива ulimit
- elasticsearch в логах обычно описывает проблему и пути ее решения

Далее мы будем работать с данным экземпляром elasticsearch.

## Задача 2

В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |


Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.
```bash
 curl -X PUT "localhost:9200/ind-1?pretty" -H 'Content-Type: application/json' -d'
> {
>   "settings": {
>     "number_of_shards": 1,
>     "number_of_replicas": 0
>   }
> }
> '
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-1"
}
 curl -X PUT "localhost:9200/ind-2?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}
'
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-2"
}
 curl -X PUT "localhost:9200/ind-3?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}
'
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-3"
}
 curl 'localhost:9200/_cat/indices?v'
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 WOmv8t6FRBSrg5Lk2iR6ug   1   0          0            0       208b           208b
green  open   ind-3 3Q-pENmES66D7CTrThqidQ   1   0          0            0       208b           208b
green  open   ind-2 9JuTTPiBSoqCpPqXgBXiDA   1   0          0            0       208b           208b


```


Получите состояние кластера `elasticsearch`, используя API.
```bash
curl -X GET "localhost:9200/_cluster/health?pretty"
{
  "cluster_name" : "elasticsearch",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 3,
  "active_shards" : 3,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0

```
Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

```
Это может произойти если добавлен новый узел в кластер Elasticsearch или удален старый. Когда узел добавляется или удаляется, реплики данных перераспределяются по узлам кластера, чтобы сохранить надежность и доступность данных. Если реплики не могут быть размещены на новых узлах (например, из-за ограничений по памяти или диску), то индекс переходит в желтое состояние.
```
Удалите все индексы.

```
curl -X DELETE 'http://localhost:9200/_all'
{"acknowledged":true}
```

**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

## Задача 3

В данном задании вы научитесь:
- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.
curl -X PUT "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/usr/share/elasticsearch/snapshots",
    "compress": true
  }
}'
{
  "acknowledged" : true
}

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.
root@debian10:/home/vagrant# curl -X PUT "localhost:9200/test?pretty" -H 'Content-Type: application/json' -d'
 {
   "settings": {
     "number_of_shards": 1,
     "number_of_replicas": 0
   }
}'

{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test"
}

curl 'localhost:9200/_cat/indices?v'
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test  rrUJHJ6hSl6R1R7qO6fKjw   1   0          0            0       208b           208b


[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`ами.
curl -X PUT "localhost:9200/_snapshot/netology_backup/snapshot_1?wait_for_completion=true&pretty"
{
  "snapshot" : {
    "snapshot" : "snapshot_1",
    "uuid" : "1sH8KxZZR7y5kD1Q0oz1qg",
    "version_id" : 7120099,
    "version" : "7.12.0",
    "indices" : [
      "test"
    ],
    "data_streams" : [ ],
    "include_global_state" : true,
    "state" : "SUCCESS",
    "start_time" : "2023-05-06T15:26:52.653Z",
    "start_time_in_millis" : 1683386812653,
    "end_time" : "2023-05-06T15:26:52.653Z",
    "end_time_in_millis" : 1683386812653,
    "duration_in_millis" : 0,
    "failures" : [ ],
    "shards" : {
      "total" : 1,
      "failed" : 0,
      "successful" : 1
    },
    "feature_states" : [ ]
  }
}

docker exec -it elastic ls -l /usr/share/elasticsearch/snapshots/
total 28
-rw-r--r-- 1 1000 root  505 May  6 15:26 index-0
-rw-r--r-- 1 1000 root    8 May  6 15:26 index.latest
drwxr-xr-x 3 1000 root 4096 May  6 15:26 indices
-rw-r--r-- 1 1000 root 8785 May  6 15:26 meta-1sH8KxZZR7y5kD1Q0oz1qg.dat
-rw-r--r-- 1 1000 root  257 May  6 15:26 snap-1sH8KxZZR7y5kD1Q0oz1qg.dat

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.
curl -X DELETE "localhost:9200/test?pretty"
{
  "acknowledged" : true
}
curl -X PUT "localhost:9200/test-2?pretty" -H 'Content-Type: application/json' -d'
 {
   "settings": {
     "number_of_shards": 1,
     "number_of_replicas": 0
   }
 }
 '
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test-2"
}

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.
curl -X POST "localhost:9200/_snapshot/netology_backup/snapshot_1/_restore?pretty" -H 'Content-Type: application/json' -d'
 {
   "indices": "*",
   "include_global_state": true
 }'
{
  "accepted" : true
}
curl 'localhost:9200/_cat/indices?pretty'
green open test-2 yVd7f8u2SMCCqYvnkzPtVg 1 0 0 0 208b 208b
green open test   KdPL7wH9Qf6mVY-FEl_WuQ 1 0 0 0 208b 208b

Подсказки:
- возможно вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `elasticsearch`

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
