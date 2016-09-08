This docker image wraps R as a single executable.


## Build the image

    cd rstudio/r-base
    docker build -t soulmachine/r-base .


## How to use it

Run R interactively,

    docker run --rm -it soulmachine/r-base R


Run Rscript,

    docker run --rm -it soulmachine/r-base Rscript -e 'library(tools);package_dependencies("dplyr")'


## Reference

* [rocker r-base](https://github.com/rocker-org/rocker/tree/master/r-base)
