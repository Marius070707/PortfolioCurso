#!/bin/bash

APACHE=$(systemctl is-active apache2 || echo "unknown")
MYSQL=$(systemctl is-active mariadb || systemctl is-active mysql || echo "unknown")
PHP_VERSION=$(php -v | head -n 1 | awk '{print $2}')
DOCKER_VERSION=$(docker --version 2>/dev/null | awk '{print $3}' | sed 's/,//')
KERNEL_VERSION=$(uname -r)
UPTIME=$(uptime -p | sed 's/^up //')

cat >/var/www/html/telemetria.json <<JSON
{
  "apache": "$APACHE",
  "mysql": "$MYSQL",
  "php_version": "$PHP_VERSION",
  "docker_version": "$DOCKER_VERSION",
  "kernel_version": "$KERNEL_VERSION",
  "uptime": "$UPTIME"
}
JSON

