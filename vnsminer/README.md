This docker image wraps `vnsminer` as a single executable.

**This docer image is public available at <https://hub.docker.com/r/soulmachine/vnsminer>**


## Build the image

    cd vnsminer
    docker build -t soulmachine/vnsminer .


## Start miner

    docker run -d --name vnsminer soulmachine/vnsminer 16 http://59.175.238.51:18888/0xd00325db52675358f0baea734b505cc9c5087d9c
