# self-ca
Simple CA on bash scripts

Готовим структуру
  1. mkdir -p db/{certs,newcerts}
  2. touch db/index.txt
  3. echo "01" > db/serial
  4. chmod 700 ./

После генерируем CA сертификат через скрипт genca.sh
После можем генерировать сертификат через genkey.sh user.name

Если количество пользователей внушительное, сохраните список в файле
после с помощью данной комманды сможете сгенерировать сертификаты 
для всез пользователей разом

cat users.txt | xargs -I {} ./genkey.sh {}

