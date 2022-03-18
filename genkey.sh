#!/bin/bash

username=$1

DIR="$(dirname "$(realpath "$0")")"

SYMBOL=S""
for symbol in {A..Z} {a..z} {0..9}; do SYMBOLS=$SYMBOLS$symbol; done
SYMBOLS=$SYMBOLS'!@#$%&*()?/\[]{}-+_=<>.,'
PWD_LENGTH=16  # длина пароля
PASSWORD=""    # переменная для хранения пароля
RANDOM=256     # инициализация генератора случайных чисел
for i in `seq 1 $PWD_LENGTH`
do
	PASSWORD=$PASSWORD${SYMBOLS:$(expr $RANDOM % ${#SYMBOLS}):1}
done


openssl req -new -newkey rsa:2048 -nodes -keyout ${username}.key -config ca.conf \
	-subj "/C=AZ/ST=Baku/L=Baku/O=COMPANY/OU=COMPANY_OU/CN=${username}/emailAddress=${username}@company.com" \
	-out ${username}.csr


openssl ca -config ca.conf -in ${username}.csr -out ${username}.crt -batch

echo "PASSWORD: $PASSWORD"

openssl pkcs12 -export -in ${username}.crt -inkey ${username}.key -certfile ca.crt -out ${username}.p12 -passout pass:$PASSWORD

openssl pkcs12 -export -nodes -out ${username}.pfx -inkey ${username}.key -in ${username}.crt -passout pass:

echo $PASSWORD > $username.pass

mkdir user/${username}
zip -r user/$username/$username.zip $username.*
mv ${username}.* ./user/${username}
