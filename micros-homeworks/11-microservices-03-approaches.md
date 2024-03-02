# Домашнее задание к занятию «Микросервисы: подходы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.


## Задача 1: Обеспечить разработку

Предложите решение для обеспечения процесса разработки: хранение исходного кода, непрерывная интеграция и непрерывная поставка. 
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- облачная система;
- система контроля версий Git;
- репозиторий на каждый сервис;
- запуск сборки по событию из системы контроля версий;
- запуск сборки по кнопке с указанием параметров;
- возможность привязать настройки к каждой сборке;
- возможность создания шаблонов для различных конфигураций сборок;
- возможность безопасного хранения секретных данных (пароли, ключи доступа);
- несколько конфигураций для сборки из одного репозитория;
- кастомные шаги при сборке;
- собственные докер-образы для сборки проектов;
- возможность развернуть агентов сборки на собственных серверах;
- возможность параллельного запуска нескольких сборок;
- возможность параллельного запуска тестов.

Обоснуйте свой выбор.

---

GitLab CI/CD - это встроенный инструмент для непрерывной интеграции и доставки в GitLab, который обеспечивает автоматизацию процессов сборки, тестирования и развертывания приложений.

#### Принципы взаимодействия:

1. **Система контроля версий Git**: Весь исходный код хранится в репозиториях GitLab.

2. **Репозиторий на каждый сервис**: Каждый сервис имеет свой собственный репозиторий.

3. **Запуск сборки по событию из системы контроля версий**: Сборка запускается автоматически при обнаружении изменений в репозитории.

4. **Запуск сборки по кнопке с указанием параметров**: Возможность запуска сборки вручную с настройками параметров.

5. **Привязка настроек к каждой сборке**: Настройки CI/CD привязаны к каждой сборке и сохраняются в виде конфигурационного файла в репозитории.

6. **Создание шаблонов для различных конфигураций сборок**: Возможность создания шаблонов CI/CD конфигураций для различных типов проектов или сервисов.

7. **Хранение секретных данных**: В GitLab есть встроенный менеджер секретов для безопасного хранения паролей, ключей доступа и других секретных данных.

8. **Кастомные шаги при сборке**: Возможность определения кастомных шагов сборки для выполнения дополнительных действий.

9. **Собственные докер-образы для сборки проектов**: GitLab CI/CD поддерживает использование собственных докер-образов для сборки проектов.

10. **Развертывание агентов сборки на собственных серверах**: Возможность развертывания агентов сборки (runners) на собственных серверах для обеспечения параллельного выполнения сборок и тестов.

11. **Параллельный запуск нескольких сборок и тестов**: GitLab CI/CD позволяет параллельно запускать несколько сборок и тестов для ускорения процесса разработки.



GitLab CI/CD обладает всеми необходимыми функциями для обеспечения непрерывной интеграции и доставки в облачной среде. Он интегрирован непосредственно с системой контроля версий GitLab, что упрощает настройку и использование. Кроме того, GitLab CI/CD поддерживает множество расширений и интеграций, что делает его гибким инструментом для различных потребностей разработки.


## Задача 2: Логи

Предложите решение для обеспечения сбора и анализа логов сервисов в микросервисной архитектуре.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- сбор логов в центральное хранилище со всех хостов, обслуживающих систему;
- минимальные требования к приложениям, сбор логов из stdout;
- гарантированная доставка логов до центрального хранилища;
- обеспечение поиска и фильтрации по записям логов;
- обеспечение пользовательского интерфейса с возможностью предоставления доступа разработчикам для поиска по записям логов;
- возможность дать ссылку на сохранённый поиск по записям логов.

Обоснуйте свой выбор.


---




ELK Stack - это набор программных продуктов, предназначенных для сбора, обработки, визуализации и анализа данных журналов (логов).

#### Принципы взаимодействия:

1. **Сбор логов в центральное хранилище**: Logstash используется для сбора логов со всех хостов, обслуживающих систему. Логи отправляются в Elasticsearch - центральное хранилище данных.

2. **Минимальные требования к приложениям**: Logstash может собирать логи из различных источников, включая stdout приложений, что позволяет минимизировать требования к приложениям для сбора логов.

3. **Гарантированная доставка логов**: Logstash обеспечивает гарантированную доставку логов до Elasticsearch, используя надежный механизм передачи данных.

4. **Обеспечение поиска и фильтрации**: Elasticsearch предоставляет мощные возможности поиска и фильтрации по записям логов с использованием своего поискового движка.

5. **Пользовательский интерфейс для разработчиков**: Kibana предоставляет пользовательский интерфейс для визуализации и анализа данных журналов, который может быть доступен для разработчиков для поиска по записям логов.

6. **Ссылка на сохранённый поиск**: Kibana позволяет сохранять поисковые запросы и фильтры, а также делиться ссылками на них для облегчения совместной работы и передачи информации.



ELK Stack обладает всеми необходимыми функциями для обеспечения сбора и анализа логов в микросервисной архитектуре. Он обеспечивает надежный сбор логов из различных источников, гарантированную доставку в центральное хранилище, мощные возможности поиска и фильтрации, а также удобный пользовательский интерфейс для визуализации и анализа данных журналов. Кроме того, возможность сохранения и обмена ссылками на поисковые запросы упрощает совместную работу разработчиков и облегчает процесс обнаружения и решения проблем.


## Задача 3: Мониторинг

Предложите решение для обеспечения сбора и анализа состояния хостов и сервисов в микросервисной архитектуре.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- сбор метрик со всех хостов, обслуживающих систему;
- сбор метрик состояния ресурсов хостов: CPU, RAM, HDD, Network;
- сбор метрик потребляемых ресурсов для каждого сервиса: CPU, RAM, HDD, Network;
- сбор метрик, специфичных для каждого сервиса;
- пользовательский интерфейс с возможностью делать запросы и агрегировать информацию;
- пользовательский интерфейс с возможностью настраивать различные панели для отслеживания состояния системы.

Обоснуйте свой выбор.


---


Для обеспечения сбора и анализа метрик состояния хостов и сервисов в микросервисной архитектуре предлагается использовать комбинацию Prometheus и Grafana.

#### Принципы взаимодействия:

1. **Сбор метрик со всех хостов и сервисов**: Prometheus предоставляет возможность сбора метрик из различных источников, включая экспортеры для мониторинга хостов и приложений.

2. **Сбор метрик состояния ресурсов хостов**: С помощью экспортеров, таких как node_exporter, можно собирать метрики CPU, RAM, HDD и Network с каждого хоста.

3. **Сбор метрик потребляемых ресурсов для каждого сервиса**: Можно использовать экспортеры, написанные для конкретных приложений или фреймворков, чтобы собирать метрики CPU, RAM, HDD и Network для каждого сервиса.

4. **Сбор специфичных метрик для каждого сервиса**: В Prometheus можно определять и собирать собственные метрики, специфичные для каждого сервиса, используя его API или механизмы экспорта.

5. **Пользовательский интерфейс для запросов и агрегирования информации**: Grafana предоставляет гибкий и удобный пользовательский интерфейс для создания запросов к метрикам, их визуализации и агрегирования.

6. **Настраиваемые панели для отслеживания состояния системы**: С помощью Grafana можно создавать различные панели мониторинга, адаптированные под конкретные потребности и требования системы.



Prometheus и Grafana - это широко используемые и проверенные инструменты для мониторинга и визуализации метрик в микросервисных архитектурах. Prometheus обеспечивает надежный сбор метрик со всех хостов и сервисов, включая метрики ресурсов и специфичные метрики для каждого приложения. Grafana, в свою очередь, предоставляет гибкий пользовательский интерфейс для работы с этими метриками, что позволяет эффективно отслеживать состояние системы и быстро реагировать на проблемы.


## Задача 4: Логи * (необязательная)

Продолжить работу по задаче API Gateway: сервисы, используемые в задаче, пишут логи в stdout. 

Добавить в систему сервисы для сбора логов Vector + ElasticSearch + Kibana со всех сервисов, обеспечивающих работу API.

### Результат выполнения: 

docker compose файл, запустив который можно перейти по адресу http://localhost:8081, по которому доступна Kibana.
Логин в Kibana должен быть admin, пароль qwerty123456.


## Задача 5: Мониторинг * (необязательная)

Продолжить работу по задаче API Gateway: сервисы, используемые в задаче, предоставляют набор метрик в формате prometheus:

- сервис security по адресу /metrics,
- сервис uploader по адресу /metrics,
- сервис storage (minio) по адресу /minio/v2/metrics/cluster.

Добавить в систему сервисы для сбора метрик (Prometheus и Grafana) со всех сервисов, обеспечивающих работу API.
Построить в Graphana dashboard, показывающий распределение запросов по сервисам.

### Результат выполнения: 

docker compose файл, запустив который можно перейти по адресу http://localhost:8081, по которому доступна Grafana с настроенным Dashboard.
Логин в Grafana должен быть admin, пароль qwerty123456.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---