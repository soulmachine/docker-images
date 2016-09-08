FROM soulmachine/r-base:latest
MAINTAINER soulmachine <soulmachine@gmail.com>

# This Dockfile is inspired by https://github.com/rocker-org/rocker/tree/master/rstudio


# Install RStudio Server, see https://www.rstudio.com/products/rstudio/download-server/
RUN apt update -qy && apt -qy --no-install-recommends install \
    wget \
    sudo \
    lsb-release \
    gdebi-core \
 && VER=$(wget --no-check-certificate -qO- https://s3.amazonaws.com/rstudio-server/current.ver) \
 && wget -q http://download2.rstudio.org/rstudio-server-${VER}-amd64.deb \
 && gdebi -n rstudio-server-${VER}-amd64.deb \
 && rm rstudio-server-*-amd64.deb \
 && apt -qy clean \
 && apt -qy autoremove \
 && rm -rf /var/lib/apt/lists/*


# Ensure that if both httr and httpuv are installed downstream, oauth 2.0 flows still work correctly.
RUN echo '\n\
\n# Configure httr to perform out-of-band authentication if HTTR_LOCALHOST \
\n# is not set since a redirect to localhost may not work depending upon \
\n# where this Docker container is running. \
\nif(is.na(Sys.getenv("HTTR_LOCALHOST", unset=NA))) { \
\n  options(httr_oob_default = TRUE) \
\n}' >> /etc/R/Rprofile.site

RUN echo "PATH=$PATH" >> /etc/R/Renviron.site


# Add a normal user for RStudio, since RStudio Server will not permit logins by system users (those with user ids lower than 100)
# Do add the user to staff group to grant the user write privileges to /usr/local/lib/R/site-library
RUN useradd rstudio --shell /bin/bash --create-home \
 && echo "rstudio:rstudio" | chpasswd \
 && addgroup rstudio staff


## Use s6 to launch rstudio server as a daemon process
RUN wget -P /tmp/ https://github.com/just-containers/s6-overlay/releases/download/v1.11.0.1/s6-overlay-amd64.tar.gz \
  && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /
COPY run.sh /etc/services.d/rstudio/run


EXPOSE      8787

## Expose a default volume for Kitematic
VOLUME /home/rstudio

CMD ["/init"]
