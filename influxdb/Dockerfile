FROM influxdb:latest

# https://github.com/influxdata/influxdata-docker/blob/master/influxdb/2.0/Dockerfile

# Install fixuid
RUN ARCH="$(dpkg --print-architecture)" && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.5.1/fixuid-0.5.1-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: influxdb\ngroup: influxdb\npaths:\n  - /home/influxdb\n  - /var/lib/influxdb2\n  - /etc/influxdb2\n" > /etc/fixuid/config.yml

USER influxdb:influxdb
ENV USER influxdb

ENTRYPOINT ["fixuid", "-q"]
CMD ["/entrypoint.sh", "influxd"]
