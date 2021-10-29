# influxdb

Run influxdb in a non-root user.

## How to use

```bash
docker run -d --name influxdb --restart always \
  -u "$(id -u):$(id -g)" \
  -p 8086:8086 \
  -v YOUR_LOCAL_PATH:/var/lib/influxdb2 \
  -e DOCKER_INFLUXDB_INIT_MODE=setup \
  -e DOCKER_INFLUXDB_INIT_USERNAME=admin \
  -e DOCKER_INFLUXDB_INIT_PASSWORD=YOUR_PASSWORD \
  -e DOCKER_INFLUXDB_INIT_ORG=YOUR_ORG_NAME \
  -e DOCKER_INFLUXDB_INIT_BUCKET=YOUR_BUCKET_NAME \
  -e DOCKER_INFLUXDB_INIT_ADMIN_TOKEN=YOUR_TOKEN \
  soulmachine/influxdb
```

## Build

```bash
docker build -t soulmachine/influxdb .
docker push soulmachine/influxdb
```
