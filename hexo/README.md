This docker image wraps [hexo](https://github.com/hexojs/hexo) as a single executable.

## Build the image

    cd hexo
    docker build -t hexo .

## How to use it

    docker run -v $(pwd):/tmp/hexo -w /tmp/hexo hexo init blog
    docker run -v $(pwd):/tmp/hexo -w /tmp/hexo/blog hexo new "Hello World"
    docker run -v $(pwd):/tmp/hexo -w /tmp/hexo/blog hexo generate
    docker run -v $(pwd):/tmp/hexo -w /tmp/hexo/blog -p 4000:4000 -d hexo server
