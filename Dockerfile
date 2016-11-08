FROM ubuntu:14.04
MAINTAINER Jagatveer Singh <jagatveer@hotmail.com>
RUN apt-get update -y && apt-get install -y curl wget git supervisor build-essential
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /data
RUN mkdir -p /logs
RUN mkdir -p /opt/sample/app
RUN curl https://raw.githubusercontent.com/isaacs/nave/master/nave.sh > /opt/nave.sh
RUN bash /opt/nave.sh usemain v5.11.1
RUN cd /opt && wget http://www.haproxy.org/download/1.5/src/haproxy-1.5.3.tar.gz
RUN cd /opt && tar xzf haproxy-1.5.3.tar.gz
RUN cd /opt/haproxy-1.5.3 && make TARGET=linux2628 && make install
ADD index.js /opt/sample/app/index.js
ADD haproxy.cfg /opt/haproxy-1.5.3/haproxy.cfg
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf
EXPOSE 80 8081 8082 8083
CMD "/usr/bin/supervisord"
