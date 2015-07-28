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
EXPOSE 80

# set volumes
VOLUME /Thumbs /Pictures

# Set the locale
RUN locale-gen en_US.UTF-8

# update apt and install dependencies
RUN add-apt-repository ppa:kirillshkrogalev/ffmpeg-next && \
apt-get update && \
apt-get install \
git-core \
nginx \
php5-fpm \
php5-gd \
libgd2-xpm-dev \
supervisor \
ffmpeg -y && \

# clean up
cd / && \
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# fetch photoshow from git and configure it
RUN git clone https://github.com/thibaud-rohmer/PhotoShow.git /var/www/PhotoShow
RUN sed -i -e 's/$config->photos_dir.\+/$config->photos_dir = "\/Pictures";/' /var/www/PhotoShow/config.php
RUN sed -i -e 's/$config->ps_generated.\+/$config->ps_generated = "\/Thumbs";/' /var/www/PhotoShow/config.php
RUN chown -R www-data:www-data /Thumbs

# set supervisor and config files
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN sed -i -e 's/^.\+daemonize.\+$/daemonize = no/' /etc/php5/fpm/php-fpm.conf
