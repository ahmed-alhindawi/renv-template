ARG R_VERSION=4.3.2
# get base image
FROM rocker/r-ver:${R_VERSION} AS os

# update libraries & install packages
RUN apt-get update -qq && \
  apt-get upgrade -y && \
  apt-get --no-install-recommends install -y \
  libxml2-dev \
  python3-pip \
  curl \
  cmake \
  libcurl4-openssl-dev \
  openssh-client \
  git \
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
WORKDIR /renv_build
ENV RENV_CONFIG_SANDBOX_ENABLED=FALSE

COPY renv.lock renv.lock
COPY .Rprofile .Rprofile 
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

# change default location of cache to project folder
RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE renv/.cache

RUN R -e "install.packages(c('languageserver'))"
RUN R -e "install.packages('remotes')" -e "remotes::install_github('nx10/httpgd')"

#########
# STAGE 3
#########
FROM os
WORKDIR /renv_build
COPY --from=tmp /renv_build .

RUN R -e "renv::restore()"
