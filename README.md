Скрипт автоматического бэкапа 1С.

Принцип работы скрипта.

1) Скрипт устанавливает удаленное подключение к OpenVPN серверу, автоматически прописывая пароль благодаря expect в файле "ask".
2) делает mount удаленного директория с 1С
3) бэкапит папку 1С с OpenVPN сервера на NAS сервер.
4) делает unmount удаленных директориев с OpenVPN сервера и сервера бэкапа NAS
5) разрывает соединение OpenVPN


P.S файл openvpn2_backup.sh доработанная версия.
