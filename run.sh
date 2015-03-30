#!/bin/sh

INFLUXDB_URL=${INFLUXDB_URL:-influxdb.adeo.no}

cat << EOF > /etc/sensu/conf.d/config.json
{
    "rabbitmq": {
        "port": 5672,
        "host": "localhost",
        "user": "guest",
        "password": "guest",
        "vhost": "/"
    },
    "redis": {
        "host": "localhost",
        "port": 6379
    },
    "api": {
        "host": "localhost",
        "port": 4567
    },
    "handlers": {
        "default": {
          "type": "pipe",
          "command": "cat"    
        },  
        "metrics": {
          "type": "set",
          "handlers": ["influx"] 
        }
    }
}
EOF

cat << EOF > /etc/sensu/conf.d/influx.json
{
    "influx": {
        "host": "$INFLUXDB_URL",
        "port": "8086",
        "user": "stats",
        "password": "stats",
        "database": "stats"
    }
}
EOF

/usr/bin/supervisord
