FROM nginx:1.9

MAINTAINER Daniel Paschke <paschdan@wirkaufens.de>
MAINTAINER Benjamin Schönebeck <benny@wirkaufens.de>

EXPOSE 80

# env's that never change
ENV ENV=prod \
    AGAN_ENV=dimwit

# basic apt state
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get clean

# install additional packages (for nginx.conf modification)
RUN apt-get update && apt-get install -y -q --no-install-recommends augeas-tools augeas-lenses

COPY ./ /
ENTRYPOINT [ "/.deploy/bash/docker_guest_wrapper.sh" ]

# install dependencies
RUN [ "/.deploy/bash/docker_guest_wrapper.sh", "install-requirements" ]

# clean up
RUN [ "/.deploy/bash/docker_guest_wrapper.sh", "clean" ]

VOLUME [ "/var/www", "/.deploy" ]
