# get base image
FROM rocker/r-base:latest as os
ARG WORKSPACE=/workspaces

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
      libfontconfig1-dev && \
      apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

RUN curl -o quarto.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.450/quarto-1.3.450-linux-amd64.deb && \
    apt-get update -qq && \
    apt-get install ./quarto.deb && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf quarto.deb

RUN pip3 install radian --break-system-packages

RUN Rscript -e "install.packages(c('renv', 'languageserver'))"

WORKDIR ${WORKSPACE}

#########
# STAGE 2
#########
FROM os as temp

WORKDIR ${WORKSPACE}

RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

RUN Rscript -e "renv::restore(confirm=FALSE)" -e "renv::isolate()"

#########
# STAGE 3
#########
FROM os
COPY --from=temp ${WORKSPACE}/renv ${WORKSPACE}/renv
