Скрипт автоматического бэкапа 1С.

Принцип работы скрипта.

1) Скрипт устанавливает удаленное подключение к OpenVPN серверу, автоматически прописывая пароль благодаря expect в файле "ask".
2) делает mount удаленного директория с 1С
3) бэкапит папку 1С с OpenVPN сервера на NAS сервер.
4) делает unmount удаленных директориев с OpenVPN сервера и сервера бэкапа NAS
5) разрывает соединение OpenVPN


P.S файл openvpn2_backup.sh доработанная версия.

P.P.S в openvpn client.conf указываем пути до сертификатов ПОЛНОСТЬЮ иначе в кроне скрипт работать не будет!!!
client
dev tun
proto udp
remote 111.111.111.111 12345
pkcs12 /etc/openvpn/cert.p12
tls-auth /etc/openvpn/ta.key 1
cipher AES-128-CBC
nobind
comp-lzo
persist-key
persist-tun
