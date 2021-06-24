FROM ubuntu:18.04
MAINTAINER Vytautas Astrauskas "vastrauskas@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# Install prerequisites.
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        locales \
        curl \
        wget \
        && \
    apt-get clean

ADD texlive.profile /tmp/texlive.profile

# Install texlive-2017.
RUN cd /tmp/ && \
    wget -q http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -O /tmp/texlive.tar.gz && \
    tar -xf /tmp/texlive.tar.gz && \
    cd install-tl-* && \
    ./install-tl --profile=/tmp/texlive.profile && \
    rm -rf /tmp/*
ENV PATH $PATH:/usr/local/texlive/2017/bin/x86_64-linux/

# Install additional tools.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        python3-pip \
        python3-setuptools \
        gnuplot \
        inkscape \
        && \
    apt-get clean && \
    pip3 install --upgrade pip && \
    pip3 install git+https://github.com/pygments/pygments@f0ff1bad7122f2604c54401b7ef1547bbeb4260f && \
	wget -c https://raw.githubusercontent.com/vakaras/inkscape-export-layers/1b9f3f274c1e011bcc4b439e8a3d89d5d925c7aa/exportlayers.py -O /usr/bin/exportlayers && \
	chmod 755 /usr/bin/exportlayers

# Set up locale.
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set up home.
ENV HOME /home/developer
RUN mkdir -p /home/developer && \
    chmod 777 /home/developer

# Mark container.
ENV TEXLIVE_CONTAINER 1

# Set the working directory.
WORKDIR /data
