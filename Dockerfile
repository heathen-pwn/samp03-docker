# samp-server-docker Dockerfile

FROM ubuntu:jammy

#Declaring the variables from .env
# TGZ_FILE is the folder name where the SAMP SERVER is
ARG TGZ_FILE 
# APP_ROOT is where server should be
ARG APP_ROOT

#adding the variables to env vars
ENV TGZ_FILE ${TGZ_FILE}
ENV APP_ROOT ${APP_ROOT}

# set up packages

RUN dpkg --add-architecture i386
RUN apt update && \
    apt upgrade -yy && \
    apt install -yy \
       libc6=2.35-0ubuntu3.1 \
       libc6-i386 \
       lib32stdc++6 

#
# copy and extract samp-server file-structure
#

# COPY ${TGZ_FILE} /tmp/
# RUN [ ! -d "${APP_ROOT}" ] && cd /srv && mv /tmp/${TGZ_FILE} .
COPY /samp03 /srv/samp03
RUN chmod ug=rx,o= /srv/samp03/start.sh

# map server log to STDOUT => use `docker logs samp-server-name` to explore it
# RUN ln -sf /dev/stdout ${APP_ROOT}/server_log.txt

#
# run server
#

EXPOSE 7778
ENTRYPOINT exec /srv/samp03/start.sh
# COPY bin/start.sh /start.sh

STOPSIGNAL SIGINT

# WORKDIR ${APP_ROOT}
WORKDIR /srv/samp03
# ENTRYPOINT exec /srv/samp03/samp03svr
# ENTRYPOINT exec top
