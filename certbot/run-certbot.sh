#!/bin/sh

certbot certonly --webroot -w /var/www/letsencrypt -d $CN --agree-tos -m $EMAIL --non-interactive --no-eff-email
# certbot --help
# cat /var/log/letsencrypt/letsencrypt.log
# cp /etc/letsencrypt/archive/$CN/cert1.pem /var/certs/cert1.pem
# cp /etc/letsencrypt/archive/$CN/privkey1.pem /var/certs/privkey1.pem
