# Домашнее задание к занятию "2. SQL"


## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

```yml
version: "3.3"
services:
  db:
    image: postgres:12
    restart: always
    environment:
      POSTGRES_USER: test-admin-user
      POSTGRES_PASSWORD: super_password
      POSTGRES_DB: test_db
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data
      - db_backups:/backups
    command: postgres -c 'password_encryption=md5' -c 'listen_addresses=*'
volumes:
  db_data:
  db_backups:
```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,

```sql

test_db=# \l
                             List of databases
   Name    | Owner | Encoding |  Collate   |   Ctype    | Access privileges
-----------+-------+----------+------------+------------+-------------------
 postgres  | root  | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | root  | UTF8     | en_US.utf8 | en_US.utf8 | =c/root          +
           |       |          |            |            | root=CTc/root
 template1 | root  | UTF8     | en_US.utf8 | en_US.utf8 | =c/root          +
           |       |          |            |            | root=CTc/root
 test_db   | root  | UTF8     | en_US.utf8 | en_US.utf8 |
(4 rows)
```

- описание таблиц (describe)

```sql

test_db=# \dt orders
        List of relations
 Schema |  Name  | Type  | Owner
--------+--------+-------+-------
 public | orders | table | root
(1 row)

test_db=# \d+ orders
                                                        Table "public.orders"
 Column |          Type          | Collation | Nullable |              Default               | Storage  | Stats target | Description
--------+------------------------+-----------+----------+------------------------------------+----------+--------------+-------------
 id     | integer                |           | not null | nextval('orders_id_seq'::regclass) | plain    |              |
 name   | character varying(255) |           |          |                                    | extended |              |
 price  | integer                |           |          |                                    | plain    |              |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_order_id_fkey" FOREIGN KEY (order_id) REFERENCES orders(id)
Access method: heap

test_db=#
```

- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db

```sql
SELECT grantee, privilege_type
FROM information_schema.table_privileges
WHERE table_schema = 'public'
  AND table_name IN ('orders', 'clients');

```
- список пользователей с правами над таблицами test_db

```sql
grantee      | privilege_type
------------------+----------------
 root             | INSERT
 root             | SELECT
 root             | UPDATE
 root             | DELETE
 root             | TRUNCATE
 root             | REFERENCES
 root             | TRIGGER
 test-admin-user  | INSERT
 test-admin-user  | SELECT
 test-admin-user  | UPDATE
 test-admin-user  | DELETE
 test-admin-user  | TRUNCATE
 test-admin-user  | REFERENCES
 test-admin-user  | TRIGGER
 test-simple-user | INSERT
 test-simple-user | SELECT
 test-simple-user | UPDATE
 test-simple-user | DELETE
 root             | INSERT
 root             | SELECT
 root             | UPDATE
 root             | DELETE
 root             | TRUNCATE
 root             | REFERENCES
 root             | TRIGGER
 test-admin-user  | INSERT
 test-admin-user  | SELECT
 test-admin-user  | UPDATE
 test-admin-user  | DELETE
 test-admin-user  | TRUNCATE
 test-admin-user  | REFERENCES
 test-admin-user  | TRIGGER
 test-simple-user | INSERT
 test-simple-user | SELECT
 test-simple-user | UPDATE
 test-simple-user | DELETE
(36 rows)

```

## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

```sql
test_db=# SELECT COUNT(*) FROM orders;
 count
-------
    10
(1 row)

test_db=# SELECT COUNT(*) FROM clients;
 count
-------
     5
(1 row)

test_db=# SELECT * FROM clients;
 id | last_name | country | order_id |      full_name
----+-----------+---------+----------+----------------------
  1 |           | USA     |          | Иванов Иван Иванович
  2 |           | Canada  |          | Петров Петр Петрович
  3 |           | Japan   |          | Иоганн Себастьян Бах
  4 |           | Russia  |          | Ронни Джеймс Дио
  5 |           | Russia  |          | Ritchie Blackmore
(5 rows)

test_db=# SELECT * FROM orders;
 id |   name    | price
----+-----------+-------
  1 | Chocolate |    10
  2 | Printer   |  3000
  3 | Book      |   500
  4 | Monitor   |  7000
  5 | Guitar    |  4000
  6 | Шоколад   |    10
  7 | Принтер   |  3000
  8 | Книга     |   500
  9 | Монитор   |  7000
 10 | Гитара    |  4000

```

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказк - используйте директиву `UPDATE`.


```sql
test_db=# UPDATE orders SET client_id = (SELECT id FROM clients WHERE full_name = 'Иванов Иван Иванович') WHERE name = 'Книга';
UPDATE orders SET client_id = (SELECT id FROM clients WHERE full_name = 'Петров Петр Петрович') WHERE name = 'Монитор';
UPDATE orders SET client_id = (SELECT id FROM clients WHERE full_name = 'Иоганн Себастьян Бах') WHERE name = 'Гитара';
UPDATE 1
UPDATE 1
UPDATE 1


test_db=# SELECT DISTINCT clients.full_name, clients.country
FROM clients
JOIN orders ON clients.id = orders.client_id;
      full_name       | country
----------------------+---------
 Иванов Иван Иванович | USA
 Петров Петр Петрович | Canada
 Иоганн Себастьян Бах | Japan
(3 rows)

```



## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.


```sql
test_db=# EXPLAIN SELECT DISTINCT clients.full_name, clients.country
FROM clients
JOIN orders ON clients.id = orders.client_id;
                                 QUERY PLAN
-----------------------------------------------------------------------------
 HashAggregate  (cost=23.83..24.43 rows=60 width=634)
   Group Key: clients.full_name, clients.country
   ->  Hash Join  (cost=11.35..23.13 rows=140 width=634)
         Hash Cond: (orders.client_id = clients.id)
         ->  Seq Scan on orders  (cost=0.00..11.40 rows=140 width=4)
         ->  Hash  (cost=10.60..10.60 rows=60 width=638)
               ->  Seq Scan on clients  (cost=0.00..10.60 rows=60 width=638)
(7 rows)
```
```HashAggregate:``` этот оператор используется для агрегации данных, в данном случае, для группировки записей из таблицы clients.
```cost:``` стоимость выполнения оператора, выраженная в условных единицах. Эта стоимость рассчитывается на основе статистики базы данных и предполагаемого количества обрабатываемых строк.
```rows:``` количество строк, обработанных оператором.
```Group Key:``` столбцы, по которым группируются записи.
```Hash Join:``` оператор объединения таблиц, который использует хэш-таблицы для выполнения операции объединения.
```Hash Cond:``` условие объединения таблиц.
```Seq Scan:``` оператор последовательного сканирования таблицы.
```width:``` ширина строк, извлекаемых из таблицы.
## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 


```
root@cfed87e363d3:/# pg_dump test_db > /var/lib/postgresql/data/test_db.sql

root@60f4f0b897e6:/# psql -d test_db -f /backups/test_db.sql
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
ALTER TABLE
COPY 5
COPY 10
 setval
--------
      5
(1 row)

 setval
--------
     10
(1 row)

ALTER TABLE
ALTER TABLE
CREATE INDEX
ALTER TABLE
ALTER TABLE
psql:/backups/test_db.sql:198: ERROR:  role "test-admin-user" does not exist
psql:/backups/test_db.sql:199: ERROR:  role "test-simple-user" does not exist
psql:/backups/test_db.sql:206: ERROR:  role "test-admin-user" does not exist
psql:/backups/test_db.sql:207: ERROR:  role "test-simple-user" does not exist
root@60f4f0b897e6:/#
```
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
