FROM ubuntu:jammy

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# basic utils
RUN apt-get update && \
	apt-get install -y apt-utils apt-transport-https sudo curl wget gettext syslinux-utils bc jq man-db uuid && \
	apt-get install -y git ntpdate ntp supervisor cron rsyslog nano net-tools inetutils-ping telnet mc rsync dnsutils iproute2 psmisc acl systemd traceroute ldap-utils tcpdump && \
	apt-get install -y software-properties-common

# workaround https://github.com/moby/moby/issues/5490
# RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump

ENV EDITOR nano

# timezone
RUN apt-get install -y tzdata

# build
RUN apt-get install -y build-essential

# locale
RUN apt-get install -y language-pack-en-base && update-locale LANG=en_US.UTF-8 && dpkg-reconfigure locales
ENV LANG=en_US.UTF-8

# node
COPY Downloads/node-v18.16.0-linux-x64.tar.xz /tmp
RUN mkdir -p /opt/nodejs && tar xvf /tmp/node-v18.16.0-linux-x64.tar.xz -C /opt/nodejs --strip-components 1 && rm -f /tmp/node-v18.16.0-linux-x64.tar.xz
ENV PATH "${PATH}:/opt/nodejs/bin"
#RUN echo 'export PATH=$PATH:/opt/nodejs/bin' >> ~/.bashrc

# bower
RUN /opt/nodejs/bin/npm install -g bower

# local web server
RUN /opt/nodejs/bin/npm install -g local-web-server

# setup
RUN echo 'alias cp="cp -i"' >> /root/.bashrc && \
	echo 'alias mv="mv -i"' >> /root/.bashrc && \
	echo 'alias rm="rm -i"' >> /root/.bashrc && \
	echo '"\e[1;5D": backward-word' >> /root/.inputrc && \
	echo '"\e[1;5C": forward-word' >> /root/.inputrc && \
        echo 'if [ -f /etc/bash_completion ] && ! shopt -oq posix; then . /etc/bash_completion; fi' >> /root/.bashrc

ENV HISTORY 1000000
ENV LANG en_US.UTF-8
ENV PS1 "[docker \h:\\w]\\\\$ "

# entrypoint & cmd
RUN mkdir /entrypoint.d
COPY run-entrypoints.sh /root
ENTRYPOINT [ "/root/run-entrypoints.sh" ]
CMD /bin/bash
