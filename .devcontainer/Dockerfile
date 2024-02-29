# define R version
ARG R_VERSION=4.3.2
# get base image
FROM rocker/r-ver:${R_VERSION} AS os

# update & install required packages/libraries
# and clean up afterwards
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

# get quarto
RUN curl -o quarto.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.550/quarto-1.4.550-linux-amd64.deb && \
   apt-get update -qq && \
   apt-get install ./quarto.deb && \
   apt-get autoremove -y && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/* && \
   rm -rf quarto.deb
# install tinytex for quarto
RUN quarto install tinytex

# install latest radian version from github
RUN pip3 install -U git+https://github.com/randy3k/radian

#########
# STAGE 2
#########
FROM os AS tmp
# set working directory
WORKDIR /renv_build
# Disable renv sandbox
ENV RENV_CONFIG_SANDBOX_ENABLED=FALSE

# copy renv files into container
# so they are accessible during build time
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile 
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

# Install packages into correct library (subject to WORKDIR)
RUN R -e "install.packages(c('languageserver'))"
RUN R -e "install.packages('remotes')" -e "remotes::install_github('nx10/httpgd')"

#########
# STAGE 3
#########
FROM os
WORKDIR /renv_build
# copy only libraries
COPY --from=tmp /renv_build .
# restore packages
RUN R -e "renv::restore()"
