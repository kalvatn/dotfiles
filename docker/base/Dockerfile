FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq
RUN apt-get install -y apt-utils
RUN apt-get install -y sudo software-properties-common dialog
RUN apt-get upgrade -y

RUN echo 'Europe/Oslo' > /etc/timezone && dpkg-reconfigure tzdata

ADD /docker-sudoers /etc/sudoers
RUN chmod 440 /etc/sudoers

RUN useradd -m kalvatn && echo "kalvatn:kalvatn" | chpasswd && adduser kalvatn sudo
RUN groupadd -f kalvatn && adduser kalvatn kalvatn
