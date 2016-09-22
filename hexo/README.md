This docker image wraps [hexo](https://github.com/hexojs/hexo) as a single executable.

## Build the image

    cd hexo
    docker build -t hexo .

Also, this images is already published to Docker Hub, so you can pull it directly,

    docker pull soulmachine/hexo


## How to use it

Create a new blog,

    docker run --rm -it -v $(pwd):/tmp/hexo -w /tmp/hexo soulmachine/hexo init blog
    docker run --rm -it -v $(pwd):/tmp/hexo -w /tmp/hexo/blog soulmachine/hexo new "Hello World"
    docker run --rm -it -v $(pwd):/tmp/hexo -w /tmp/hexo/blog soulmachine/hexo generate
    docker run -v $(pwd):/tmp/hexo -w /tmp/hexo/blog -p 4000:4000 -d soulmachine/hexo server

Compile an existing blog,

    git clone https://github.com/soulmachine/cn-blog.git
    cd cn-blog/
    docker run --rm -it -v $(pwd):/tmp/cn-blog -w /tmp/cn-blog --entrypoint npm soulmachine/hexo install
    docker run --rm -it -v $(pwd):/tmp/cn-blog -w /tmp/cn-blog soulmachine/hexo generate
    docker run -v $(pwd):/tmp/cn-blog -w /tmp/cn-blog -p 4000:4000 -d soulmachine/hexo server
