This docker image wraps [markdown2confluence](https://github.com/jedi4ever/markdown2confluence) as a single executable.

## Build the image

    cd markdown2confluence/docker
    docker build -t soulmachine/markdown2confluence .

Also, this images is already published to Docker Hub, so you can pull it directly,

    docker pull soulmachine/markdown2confluence


## How to use it

For example, you have a markdown document named `sample.md` under the current directory, you can compile it by running:

    docker run -v $(pwd):/tmp/work soulmachine/markdown2confluence /tmp/work/sample.md

