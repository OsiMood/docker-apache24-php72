#!/bin/bash

echo "=> Env Variables"
echo "APP_ENV : ${APP_ENV}"
echo "PORT : ${PORT}"
echo "VHOST : ${VHOST}"
echo "WWW : ${WWW}"
echo ""

echo "=> Initialisation du vhost"
sed -i.bak s/'${APP_ENV}'/"${APP_ENV}"/g /tmp/template.conf
sed -i.bak s/'${PORT}'/"${PORT}"/g /tmp/template.conf
sed -i.bak s/'${VHOST}'/"${VHOST}"/g /tmp/template.conf
sed -i.bak s+'${WWW}'+${WWW}+g /tmp/template.conf
echo ""

echo "=> Reading conf file:"
cat /tmp/template.conf
echo ""

cp /tmp/template.conf /etc/apache2/sites-enabled/${VHOST}.conf

echo "=> Starting Apache as a service"
#httpd -D FOREGROUND
service apache2 start
tail -f /var/log/apache2/${VHOST}_access.log
