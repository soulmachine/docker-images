This docker image wraps RStudio Server as a single executable.


## Build the image

    # need to build r-base first
    cd rstudio/r-base
    docker build -t r-base .

    cd rstudio/rstudio
    docker build -t rstudio .


## How to use it

    docker run -d -p 8787:8787 rstudio

Then open <http://localhost:8087> in browser, the username and password are both `rstudio`.


## Reference

* [rocker](https://github.com/rocker-org/rocker)
