FROM docker.io/alpine:latest

# install haproxy and bash packages
RUN apk --no-cache add haproxy bash

# prepare local configuration structure
RUN mkdir -p /usr/local/etc/haproxy/conf.d
COPY conf/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
RUN chown root:        -R /usr/local/etc/haproxy
RUN chmod u=rwX,go=rX  -R /usr/local/etc/haproxy

# volumes declarations
VOLUME /usr/local/etc/haproxy/conf.d

# prepare entrypoint
COPY entrypoint.bash /usr/local/bin/entrypoint.bash
RUN chmod u=rwx,go=rx /usr/local/bin/entrypoint.bash

# 'haproxy' user is present after
#  installing 'haproxy' software via apk
USER haproxy
ENTRYPOINT ["/usr/local/bin/entrypoint.bash"]