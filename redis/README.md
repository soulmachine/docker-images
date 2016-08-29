This docker image wraps redis as a single executable.


## Build the image

    cd redis
    docker build -t redis .


## How to use it

    docker run -p 6379:6379 -d redis


## Reference

* [Dockerizing a Redis service](https://docs.docker.com/engine/examples/running_redis_service/)

