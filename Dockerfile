#asterisk docker file for unraid 6
FROM phusion/baseimage:0.9.15
MAINTAINER marc brown <marc@22walker.co.uk> v0.0.1
EXPOSE 6789 6791

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# map /data to host defined data path (used to store downloads or use blackhole)
VOLUME /data

# map /media to host defined media path (used to read/write to media library)
VOLUME /media

# add supervisor conf file for app
ADD nzbget.conf /etc/supervisor/conf.d/nzbget.conf
#Set work Dir
WORKDIR /tmp
#Install dep
RUN apt-get install build-essential libncurses5-dev libssl-dev libxml2-dev -y \
#get NZBGET and unpack
  && wget http://sourceforge.net/projects/nzbget/files/nzbget-14.2.tar.gz \
  && tar -zxf nzbget-14.2.tar.gz \
  && cd /tmp/nzbget-14.2 \
  && ./configure \
  && make \
  && make install \
  && make install-strip
