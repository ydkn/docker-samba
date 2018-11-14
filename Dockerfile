FROM debian:buster-slim
MAINTAINER Florian Schwab <me@ydkn.de>

# update system
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y -qq

# install nss-ldap, samba
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --fix-missing --no-install-recommends \
    runit tini ca-certificates libnss-ldapd libpam-ldapd samba samba-vfs-modules samba-dsdb-modules

# enable nss-ldap
RUN sed -i "/^passwd:/c\passwd:\t\tcompat ldap" /etc/nsswitch.conf
RUN sed -i "/^group:/c\group:\t\tcompat ldap" /etc/nsswitch.conf
RUN sed -i "/^shadow:/c\shadow:\t\tcompat ldap" /etc/nsswitch.conf

# copy scripts
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY samba-user.sh /usr/local/bin/samba-user
COPY service /etc/service

# cleanup
RUN rm -rf /tmp/* /var/tmp/* /usr/share/man/* /usr/share/doc/*

# volumes
VOLUME ["/etc/samba"]
VOLUME ["/var/lib/samba"]
VOLUME ["/home"]

# expose ports
EXPOSE 137/udp 138/udp 139 445

# entrypoint
ENTRYPOINT ["tini", "--", "docker-entrypoint.sh"]

# default command
CMD ["runsvdir", "/etc/service"]
