FROM debian:jessie
MAINTAINER Christoph Döberl, christoph@doeberl.at

# ARG DEBIAN_FRONTEND=noninteractive

# install https-transport
RUN apt-get update
RUN apt-get install locales apt-transport-https -y

# install weechat repo key
RUN apt-key adv --keyserver pool.sks-keyservers.net \
                --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E

# get the repo
RUN bash -c "echo 'deb https://weechat.org/debian jessie main' >/etc/apt/sources.list.d/weechat.list"

# update sources
RUN apt-get update && \
    apt-get upgrade -y

# set environment vars
ENV TERM rxvt-unicode-256color

## Set the timezone (change this to your local timezone)
RUN echo "Europe/Berlin" | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

# install packages
RUN apt-get -y install \
    python-potr \
    rxvt-unicode-256color \
    weechat \
    weechat-scripts

# Set the locale (I want to use German Umlauts)
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# create custom user
RUN adduser --disabled-login --gecos '' user
USER user
WORKDIR /home/user

ENTRYPOINT weechat
