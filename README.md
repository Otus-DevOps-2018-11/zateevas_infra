# zateevas Infra repository
## Лабораторная №5
### Задание 1

Команда для подключения в одну строку - `ssh -A -t 104.199.47.179 'ssh 10.132.0.3'`

### Дополнительное задание 1
Для подключения через алиас добавляем в файл ~/.ssh/config строки следующего вида:

```
Host someinternalhost
      HostName <Внешний IP адрес VM Bastion>
      IdentityFile ~/.ssh/<Используемый приватный ключ>
      RequestTTY force
      RemoteCommand ssh <Внутренний IP адрес someinternalhost>
      ForwardAgent yes
```
### Дополнительное задание 2
Решается путем добавления сроки 104.199.47.179.xip.io в поле Lets Encrypt Domain настроек pritunl

### Задание 2
Получившеяся конфигурация:

bastion_IP = 104.199.47.179

someinternalhost_IP = 10.132.0.3

## Лабораторная №6
### Задание 1

Данные для проверки:

testapp_IP = 35.241.233.135

testapp_port = 9292

### Дополнительное задание 1
Команда gcloud для создания VM с использованием локального скрипта

```
gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--metadata-from-file startup-script=/home/zateevas/repo/zateevas_infra/startup_script
```

Команда gcloud для создания VM с использованием удаленного скрипта в gcs

```
gcloud compute instances create reddit-app-test \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--metadata startup-script-url=gs://zateevas_1/startup_script
```

### Дополнительное задание 2
Команда создания правила firewall для серверов с тегом puma-server
```
gcloud compute firewall-rules create default-puma-server \
	--action allow \
	--network default \
	--priority 1000 \
	--target-tags puma-server \
	--source-ranges 0.0.0.0/0 \
	--rules tcp:9292
```

## Лабораторная №7

1. Шаблон параметризирован

2. Добавлены дополнительные параметры

3. Создан шаблон immutable.json, скрипт deploy.sh немного переделан, создан unit reddit.service. Работоспособность шаблона проверена

4. Создан скрипт для развертывания VM reddit-full. работоспособность скрипта проверена. 

## Лабораторная №8

1. Созданы tf файлы для развертывания vm, правила firewall, loab balancer, переменные параметризированы
2. Сделано доп задание со звездочкой. Проблема заключается в затирании ключа, добавленного через веб интерфейс, терраформом 
3. Сделано доп задание с двумя звездочками. Проблема с описанием вм без использования count - лишний код и плохая масштабируемость.


## Лабораторная №9

1. Созданы отдельные модули для app и db
2. Организовано хранение стейт файла в удаленном бекенде
3. Внесены необходимые правки для работоспособности приложения. Работоспособность приложения после развертывания проверена. 

## Лабораторная №10

1. Ответ на вопрос - изменился вывод команды, потому что на этот раз постребовалась смена состояния репозитория
2. Сделан скрипт для динамического инвентори
