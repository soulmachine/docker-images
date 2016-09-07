This docker image wraps R as a single executable.


## Build the image

    cd rstudio/r-base
    docker build -t r-base .


## How to use it

Run R interactively,

    docker run --rm -it r-base R


Run Rscript,

    docker run --rm -it r-base Rscript -e 'library(tools);package_dependencies("dplyr")'


## Reference

* [rocker r-base](https://github.com/rocker-org/rocker/tree/master/r-base)
