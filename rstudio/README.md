This docker image wraps RStudio Server as a single executable.


## Build the image

    # need to build r-base first
    docker build -t soulmachine/r-base r-base/
    docker build -t soulmachine/rstudio rstudio/


## How to use it

    docker run -d -p 8787:8787 soulmachine/rstudio

Then open <http://localhost:8787> in browser, the username and password are both `rstudio`.


## Reference

* [rocker](https://github.com/rocker-org/rocker)
