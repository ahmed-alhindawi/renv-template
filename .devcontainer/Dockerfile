# Define R version
ARG R_VERSION_MAJ=4.3
ARG R_VERSION_MIN=3
# Get base image
FROM rocker/r-ver:${R_VERSION_MAJ}.${R_VERSION_MIN} AS os

ARG R_VERSION_MAJ

RUN apt-get update -qq && \
  apt-get upgrade -y && \
  apt-get --no-install-recommends install -y \
  git \
  curl \
  cmake \
  jags \
  openssh-client \
  pandoc \
  python3-pip \
  libxml2-dev \
  libcurl4-openssl-dev \
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
  libfontconfig1-dev \
  r-cran-tcltk2  && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Get quarto
RUN curl -o quarto.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.550/quarto-1.4.550-linux-amd64.deb && \
   apt-get update -qq && \
   apt-get install ./quarto.deb && \
   apt-get autoremove -y && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/* && \
   rm -rf quarto.deb
# install tinytex for quarto
RUN quarto install tinytex

# Install tinytex for quarto pdf rendering
RUN quarto install tinytex

# Install radian console from github
RUN pip3 install -U git+https://github.com/randy3k/radian

# Disable RENV sandbox
ENV RENV_CONFIG_SANDBOX_ENABLED=FALSE

# Location of global cache
ENV RENV_PATHS_CACHE /renv_cache

# Tell quarto R instance where workspace library is located
RUN touch /root/.Renviron && \
  echo R_LIBS_USER="/workspaces/renv/library/${R_VERSION_MAJ}/x86_64-pc-linux-gnu" > /root/.Renviron
