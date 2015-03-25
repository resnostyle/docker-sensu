# sensu docker image (based on https://github.com/arcus-io/docker-sensu)

processes (handled by supervisord):
- sensu-server
- redis
- sensu-api (exposed at 4567)
- rabbitmq (exposed at 5672)

The image includes configuration for handling influxdb events

