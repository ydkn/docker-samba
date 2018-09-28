FROM alpine:3.8
MAINTAINER Florian Schwab <me@ydkn.de>

# update system
RUN apk --no-cache --no-progress upgrade

# install samba
RUN apk --no-cache --no-progress add samba

# copy scripts
COPY samba.sh /usr/local/bin/samba.sh
COPY samba-user.sh /usr/local/bin/samba-user

# volumes
VOLUME ["/etc/samba"]
VOLUME ["/var/lib/samba"]
VOLUME ["/home"]

# expose ports
EXPOSE 137/udp 138/udp 139 445

# default command
CMD ["samba.sh"]
