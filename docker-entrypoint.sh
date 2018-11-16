#!/bin/bash
echo "Entry ss-panel"

if [ "$CREATE_ADMIN" = "true" ];then
  echo "create admin"
  php -n /var/www/html/xcat createAdmin
else
  echo "skip create admin"
fi

chmod -R 777 /var/www/html/storage
echo 'Starting Web....'
exec "$@"
