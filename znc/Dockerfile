# set base os
FROM phusion/baseimage:0.9.16
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

MAINTAINER Mark Burford <sparklyballs@gmail.com>

# Set correct environment variables
ENV DEBIAN_FRONTEND noninteractive 
ENV HOME /root 
ENV TERM screen
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US:en 
ENV LC_ALL en_US.UTF-8

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# set ports
EXPOSE 6501

# Set the locale
RUN locale-gen en_US.UTF-8


# update apt and install build dependencies
RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
echo "deb-src http://archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
apt-get update && \
apt-get install \
libsasl2-dev \ 
python3-dev \
libssl-dev \
libperl-dev \
swig3.0 \
libicu-dev \
tcl8.6-dev \
g++ \
git-core \
autogen \
pkg-config \
automake \
autoconf -y 

# fetch source from git
RUN cd /tmp && \
git clone https://github.com/znc/znc.git --recursive && \

# build znc 
cd znc && \
git clean -xdf && \
./autogen.sh && \
./configure \
--enable-cyrus \
--enable-python \
--enable-swig \
--enable-tcl \
--enable-perl \
--disable-ipv6 && \
make && \
make install && \

# clean build dependencies
apt-get purge --remove \
build-essential \
pkg-config \
make \
autoconf \
automake \
tcl8.6-dev \
libicu-dev \
swig3.0 -y && \
apt-get autoremove -y && \

# install runtime dependencies
apt-get update && \
apt-get install \
--no-install-recommends \
tcl8.6 \
supervisor \
libicu52 \
libperl5.18 -y && \
apt-get clean -y && \ 
rm -rf /var/lib/apt/lists/*
