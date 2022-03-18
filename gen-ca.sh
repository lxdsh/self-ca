#!/bin/bash


openssl req -new -newkey rsa:2048 -nodes -keyout ca.key -x509 -days 3650 -out ca.crt
