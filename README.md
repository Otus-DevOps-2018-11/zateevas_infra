zateevas Infra repository
# Задание 1
# Команда для подключения в одну строку - ssh -A -t 104.199.47.179 'ssh 10.132.0.3'

# Дополнительное задание 1
# Для подключения через алиас добавляем в файл ~/.ssh/config строки следующего вида:

#Host someinternalhost
#     HostName <Внешний IP адрес VM Bastion>
#     IdentityFile ~/.ssh/<Используемый приватный ключ>
#     RequestTTY force
#     RemoteCommand ssh <Внутренний IP адрес someinternalhost>
#     ForwardAgent yes

# Дополнительное задание 2
# Решается путем добавления сроки 104.199.47.179.xip.io в поле Lets Encrypt Domain настроек pritunl

bastion_IP = 104.199.47.179
someinternalhost_IP = 10.132.0.3

