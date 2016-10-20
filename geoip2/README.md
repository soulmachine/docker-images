Dockerizes [MaxMind GeoIP2](https://pypi.python.org/pypi/geoip2) as an executable command.

## Build the image

    cd docker-images/geoip2
    docker build -t soulmachine/geoip2 .

Also, this images is already published to Docker Hub, so you can pull it directly,

    docker pull soulmachine/geoip2


## How to use it

First, download a GeoIP2 database file into a directory on host, let's use the free version database as an example,

    wget http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz
    tar -zxf GeoLite2-City.mmdb.gz

Then we can query any IP address:

    docker run --rm -it -v $(pwd):/tmp/geoip_databases -w /tmp/geoip_databases soulmachine/geoip2 GeoLite2-City.mmdb 128.101.101.101


## Referrence

* <https://pypi.python.org/pypi/geoip2>

