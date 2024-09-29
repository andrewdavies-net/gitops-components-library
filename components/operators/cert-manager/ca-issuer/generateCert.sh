#!/bin/bash

if [ ! -e ./tls.key ]; then  
  openssl req -x509 -newkey rsa:4096 -keyout tls.key -out tls.crt -sha256 -days 3650 \
               -nodes -subj "/C=UK/ST=Hampshire/L=Hursley/O=IBM/OU=OCP/CN=ca"
fi

oc apply -k .