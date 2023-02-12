
# Домашнее задание к занятию "2. Применение принципов IaaC в работе с виртуальными машинами"

## Задача 1

- Опишите своими словами основные преимущества применения на практике IaaC паттернов.
Скорость и уменьшение затрат: Позволяет быстрее конфигурировать инфраструктуру, равернуть ее и удалить при необходимости. Возможность платить только при потребности в испрользовании.  
Масштабируемость и стандартизация: : IaC предоставляет стабильные среды быстро и на должном уровне. Достаточно выбрать одину стабильную конфигурацию для оптимальной работы приложения.
Восстановление в аварийных ситуациях: IaC — чрезвычайно эффективный способ отслеживания инфраструктуры и повторного развертывания последнего работоспособного состояния после сбоя или катастрофы любого рода. Так как описание инфраструктуры можно вложить в несколько файлов то и версии этих файлов будут хранится в репозиториях которые можно будет восстановить в случае багов или проблем работы приложения.

- Какой из принципов IaaC является основополагающим?
Идемпотентность (получаемый результат идентичный предыдущему и всем последующим выполнениям). Каждый узел будет настроен одинаково у всех разработчиков, среда разработки не меняется и если потребуется ее изменить то достаточно редактировать один файл.
## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
Конфигурации в Ansible пишутся на Python что в свою очередь является простым и понятным языком.

- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?
Я думаю что pull метод так как конфигурация проходит без SSH а берется из приватного репозитория.

## Задача 3

Установить на личный компьютер:

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://github.com/netology-code/devops-materials)
- [Terraform](https://github.com/netology-code/devops-materials/blob/master/README.md)
- Ansible

![Vagrant Terraform Ansible](\img\Screenshot_1.png)`
![VirtualBox](\img\Screenshot_2.png)`


## Задача 4 

Воспроизвести практическую часть лекции самостоятельно.

- Создать виртуальную машину.
- Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
```
docker ps
```
![ansible](\img\Screenshot_3.png)`
![host](\img\Screenshot_4.png)`