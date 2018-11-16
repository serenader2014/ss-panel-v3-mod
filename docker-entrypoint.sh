#!/bin/bash
echo "Entry ss-panel"

chmod -R 777 /var/www/html/storage
echo 'Starting Web....'
exec "$@"
