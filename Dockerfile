FROM ubuntu

MAINTAINER zocker-160

ENV Term xterm
ENV DEBIAN_FRONTEND noninteractive

RUN useradd -ms /bin/bash linux
RUN echo 'linux:debian' | chpasswd
RUN echo 'root:debian' | chpasswd
RUN usermod -aG sudo linux

RUN mkdir /var/run/sshd
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:x2go/stable
RUN apt-get update
RUN apt-get install -y \
	x2goserver \
	x2goserver-xsession \
	openssh-server

# SSH login workaround
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

EXPOSE 22

 
