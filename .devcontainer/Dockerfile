ARG R_VERSION=4.3.2
# get base image
FROM rocker/r-ver:${R_VERSION} AS os

# update libraries & install packages
RUN apt-get update -qq && \
  apt-get upgrade -y && \
  apt-get --no-install-recommends install -y \
  git \
  libxml2-dev \
  python3-pip \
  curl \
  cmake \
  libcurl4-openssl-dev \
  openssh-client \
  pandoc \
  jags \
  libv8-dev \
  libharfbuzz-dev \
  libfribidi-dev \ 
  libpng-dev \
  libtiff5-dev \
  libjpeg-dev \
  libcairo2-dev \
  libssh2-1-dev \
  libssl-dev \
  libudunits2-dev \
  libgdal-dev \
  libmagick++-dev \
  libglpk-dev \
  r-cran-tcltk2 \
  libfontconfig1-dev && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* 

RUN pip3 install -U git+https://github.com/randy3k/radian

#########
# STAGE 2
#########
FROM os AS tmp
WORKDIR /workspaces
ENV RENV_CONFIG_SANDBOX_ENABLED=FALSE

# location of global cache
ENV RENV_PATHS_CACHE /renv_cache
# location of the renv cache on the host machine
ENV RENV_PATHS_CACHE_HOST /path/to/renv_cache
# where the cache should be mounted in the container
ENV RENV_PATHS_CACHE_CONTAINER /renv_cache

COPY renv.lock renv.lock
COPY .Rprofile .Rprofile 
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json
