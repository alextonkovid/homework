# Домашнее задание к занятию "1. Инфраструктура как код"

## Задача 1. Выбор инструментов. 
 
### Легенда
 
Через час совещание на котором менеджер расскажет о новом проекте. Начать работу над которым надо 
будет уже сегодня. 
На данный момент известно, что это будет сервис, который ваша компания будет предоставлять внешним заказчикам.
Первое время, скорее всего, будет один внешний клиент, со временем внешних клиентов станет больше.

Так же по разговорам в компании есть вероятность, что техническое задание еще не четкое, что приведет к большому
количеству небольших релизов, тестирований интеграций, откатов, доработок, то есть скучно не будет.  
   
Вам, как девопс инженеру, будет необходимо принять решение об инструментах для организации инфраструктуры.
На данный момент в вашей компании уже используются следующие инструменты: 
- остатки Сloud Formation, 
- некоторые образы сделаны при помощи Packer,
- год назад начали активно использовать Terraform, 
- разработчики привыкли использовать Docker, 
- уже есть большая база Kubernetes конфигураций, 
- для автоматизации процессов используется Teamcity, 
- также есть совсем немного Ansible скриптов, 
- и ряд bash скриптов для упрощения рутинных задач.  

Для этого в рамках совещания надо будет выяснить подробности о проекте, что бы в итоге определиться с инструментами:

1. Какой тип инфраструктуры будем использовать для этого проекта: изменяемый или не изменяемый?
```Изменяемый, так как со временем внешних клиентов станет больше и нужно предусмотреть гибкость.```
1. Будет ли центральный сервер для управления инфраструктурой?
```Будет много внешних заказчиков, по этому лучше разворачивать сервисы в облаке.``
1. Будут ли агенты на серверах?
```Нет, Ansible не требует агента на сервере.```
1. Будут ли использованы средства для управления конфигурацией или инициализации ресурсов? 
```Terraform и Ansible```
В связи с тем, что проект стартует уже сегодня, в рамках совещания надо будет определиться со всеми этими вопросами.

### В результате задачи необходимо

1. ~~Ответить на четыре вопроса представленных в разделе "Легенда".~~
1. Какие инструменты из уже используемых вы хотели бы использовать для нового проекта? 
```Kubernetes и Teamcity```
1. Хотите ли рассмотреть возможность внедрения новых инструментов для этого проекта? 
```Да, инструменты мониторинга.```

Если для ответа на эти вопросы недостаточно информации, то напишите какие моменты уточните на совещании.


## Задача 2. Установка Terraform. 

[Официальный сайт Terraform](https://www.terraform.io/).   
В связи с недоступностью ресурсов для загрузки Terraform на территории РФ, вы можете воспользоваться VPN или использовать зеркало YandexCloud:      
[Ссылки для установки открытого ПО](https://github.com/netology-code/devops-materials/blob/master/README.md)

Установите терраформ при помощи менеджера пакетов используемого в вашей операционной системе.
В виде результата этой задачи приложите вывод команды `terraform --version`.
```bash
$ terraform --version
Terraform v1.4.6
on linux_amd64
```
## Задача 3. Поддержка легаси кода. 

В какой-то момент вы обновили терраформ до новой версии, например с 0.12 до 0.13. 
А код одного из проектов настолько устарел, что не может работать с версией 0.13. 
В связи с этим необходимо сделать так, чтобы вы могли одновременно использовать последнюю версию терраформа установленную при помощи
штатного менеджера пакетов и устаревшую версию 0.12. 

В виде результата этой задачи приложите вывод `--version` двух версий терраформа доступных на вашем компьютере 
или виртуальной машине.

```bash
tfswitch
Creating directory for terraform binary at: /root/.terraform.versions
✔ 1.4.5
Downloading to: /root/.terraform.versions
20767621 bytes downloaded
Switched terraform to version "1.4.5"
tfswitch
✔ 1.4.6
Downloading to: /root/.terraform.versions
20779821 bytes downloaded
Switched terraform to version "1.4.6"
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---