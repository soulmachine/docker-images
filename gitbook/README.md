This docker image wraps [gitbook](https://github.com/GitbookIO/gitbook) as a single executable.

## Build the image

    cd docker-images/gitbook
    docker build -t soulmachine/gitbook .

Also, this images is already published to Docker Hub, so you can pull it directly,

    docker pull soulmachine/gitbook


## How to use it

### Create a new book

    docker run -v $(pwd):/tmp/mybook -w /tmp/mybook soulmachine/gitbook init
    docker run -v $(pwd):/tmp/mybook -w /tmp/mybook soulmachine/gitbook install
    docker run -v $(pwd):/tmp/mybook -w /tmp/mybook soulmachine/gitbook build
    docker run -v $(pwd):/tmp/mybook -w /tmp/mybook -p 4000:4000 -d soulmachine/gitbook serve

### Compile an existing book

Let's compile [this book](https://github.com/soulmachine/algorithm-essentials) for example,

    git clone https://github.com/soulmachine/algorithm-essentials.git
    cd algorithm-essentials
    docker run -v $(pwd):/tmp/mybook -w /tmp/mybook soulmachine/gitbook install
    docker run -v $(pwd):/tmp/mybook -w /tmp/mybook soulmachine/gitbook build
    docker run -v $(pwd):/tmp/mybook -w /tmp/mybook -p 4000:4000 -d soulmachine/gitbook serve
