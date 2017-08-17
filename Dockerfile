FROM ubuntu:16.04
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

# Install additional tools.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        python-pip \
        python-setuptools \
        gnuplot \
        inkscape \
        && \
    apt-get clean && \
    pip install --upgrade pip && \
    pip install https://bitbucket.org/vakaras/pygments-main/get/tip.zip#egg=pygments

# Set up locale.
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
