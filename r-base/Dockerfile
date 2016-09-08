FROM ubuntu:xenial
MAINTAINER soulmachine <soulmachine@gmail.com>

# Elimenate the waring message: "debconf: unable to initialize frontend: Dialog"
ENV DEBIAN_FRONTEND noninteractive

# This Dockfile is inspired by https://github.com/rocker-org/rocker/tree/master/r-base


# Elimenate the warning message: delaying package configuration, since apt-utils is not installed
RUN apt update -qy && apt -qy install apt-utils \
 && apt clean \
 && apt autoremove \
 && rm -rf /var/lib/apt/lists/*


# Configure default locale
RUN apt update -qy && apt -qy install locales \
 && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && locale-gen en_US.UTF-8 \
 && /usr/sbin/update-locale LANG=en_US.UTF-8 \
 && apt clean \
 && apt autoremove \
 && rm -rf /var/lib/apt/lists/*

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en


# Install R, see https://cran.rstudio.com/bin/linux/ubuntu/README.html
RUN echo "deb http://cloud.r-project.org/bin/linux/ubuntu xenial/" | tee --append /etc/apt/sources.list \
 && echo "deb http://mirror.math.princeton.edu/pub/ubuntu/ trusty-backports main restricted universe" | tee --append /etc/apt/sources.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 \
 && apt update -qy && apt -qy --no-install-recommends install \
    r-base \
    r-base-dev \
    r-recommended \
 && apt -qy clean \
 && apt -qy autoremove \
 && rm -rf /var/lib/apt/lists/*


# Set a default CRAN mirror
RUN echo 'options(repos = c(CRAN = "https://cran.rstudio.com/"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site


# Install essential R packages
RUN apt update -qy && apt -qy install \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
 && Rscript -e 'if(!require("RCurl")) install.packages("RCurl", dependencies = TRUE)' \
 && apt -qy clean \
 && apt -qy autoremove \
 && rm -rf /var/lib/apt/lists/*

RUN apt update -qy && apt -qy install \
    libpq-dev \
    libmysqlclient-dev \
 && Rscript -e 'if(!require("dplyr")) install.packages("dplyr", dependencies = TRUE)' \
 && apt -qy clean \
 && apt -qy autoremove \
 && rm -rf /var/lib/apt/lists/*

RUN Rscript -e 'if(!require("devtools")) install.packages("devtools", dependencies = TRUE)'
RUN Rscript -e 'if(!require("rmarkdown")) install.packages("rmarkdown", dependencies = TRUE)'
RUN Rscript -e 'if(!require("knitr")) install.packages("knitr", dependencies = TRUE)'
RUN Rscript -e 'if(!require("swirl")) install.packages("swirl", dependencies = TRUE)'
RUN Rscript -e 'if(!require("ggplot2")) install.packages("ggplot2", dependencies = TRUE)'

RUN apt update -qy && apt -qy install \
    libxt-dev \
    libcairo2-dev \
 && Rscript -e 'if(!require("shiny")) install.packages("shiny", dependencies = TRUE)' \
 && apt -qy clean \
 && apt -qy autoremove \
 && rm -rf /var/lib/apt/lists/*


CMD ["R"]
