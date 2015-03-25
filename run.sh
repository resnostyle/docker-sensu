#!/bin/sh
#DASHBOARD_USER=${DASHBOARD_USER:-admin}
#DASHBOARD_PASS=${DASHBOARD_PASS:-sensu}
#SENSU_HOST=${SENSU_HOST:-localhost}
#SKIP_CONFIG=${SKIP_CONFIG:-}
#SENSU_CONFIG_URL=${SENSU_CONFIG_URL:-}
#SENSU_CLIENT_CONFIG_URL=${SENSU_CLIENT_CONFIG_URL:-}
#SENSU_CHECKS_CONFIG_URL=${SENSU_CHECKS_CONFIG_URL:-}
#
#if [ ! -z "$SENSU_CONFIG_URL" ] ; then
#    wget --no-check-certificate -O /etc/sensu/config.json $SENSU_CONFIG_URL
#else
#    if [ ! -e "/etc/sensu/config.json" ] ; then
#        cat << EOF > /etc/sensu/config.json
#{
#  "rabbitmq": {
#    "port": 5672,
#    "host": "$SENSU_HOST",
#    "user": "guest",
#    "password": "guest",
#    "vhost": "/"
#  },
#  "redis": {
#    "host": "$SENSU_HOST",
#    "port": 6379
#  },
#  "api": {
#    "host": "$SENSU_HOST",
#    "port": 4567
#  },
#  "dashboard": {
#    "host": "$SENSU_HOST",
#    "port": 8080,
#    "user": "$DASHBOARD_USER",
#    "password": "$DASHBOARD_PASS"
#  },
#  "handlers": {
#    "default": {
#      "type": "pipe",
#      "command": "true"
#    }
#  }
#}
#
#EOF
#    fi
#fi
#
#if [ ! -z "$SENSU_CLIENT_CONFIG_URL" ] ; then
#    wget --no-check-certificate -O /etc/sensu/conf.d/client.json $SENSU_CLIENT_CONFIG_URL
#else
#    if [ ! -e "/etc/sensu/conf.d/client.json" ] ; then
#    cat << EOF > /etc/sensu/conf.d/client.json
#{
#    "client": {
#      "name": "sensu-server",
#      "address": "127.0.0.1",
#      "subscriptions": [ "default", "sensu" ]
#    }
#}
#EOF
#    fi
#fi
#
#if [ ! -z "$SENSU_CHECKS_CONFIG_URL" ] ; then
#    wget --no-check-certificate -O /etc/sensu/conf.d/checks.json $SENSU_CHECKS_CONFIG_URL
#else
#    if [ ! -e "/etc/sensu/conf.d/checks.json" ] ; then
#    	cat << EOF > /etc/sensu/conf.d/checks.json
#{
#  "checks": {
#    "diskmetric": {
#      "handlers": [
#        "default", "metrics"
#      ],
#      "command": "/etc/sensu/plugins/system/disk-metrics.rb",
#      "interval": 5,
#      "occurrences": 2,
#      "refresh": 300,
#      "subscribers": [ "sensu" ]
#    }
#  }
#}
#EOF
#  fi
#fi
#
#mkdir -p /etc/sensu/conf.d/metrics
#
#cat << EOF > /etc/sensu/conf.d/metrics/influx.json
#{
#  "influx": {
#    "host": "dockerhost",
#    "port": "8086",
#    "user": "stats",
#    "password": "stats",
#    "database": "stats",
#  }
#}
#EOF
#
#cat << EOF > /etc/sensu/conf.d/handlers/metrics.json
#{
#  "handlers": {
#    "metrics": {
#      "type": "set",
#      "handlers": [ "debug", "influx"]
#    }
#  }
#}
#EOF
/usr/bin/supervisord
