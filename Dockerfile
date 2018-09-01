# Copyright 2017 Kamal Advani. All rights reserved.
# Use of this source code is governed under the Apache License, Version 2.0
# that can be found in the LICENSE file.
#
# Doc: https://docs.docker.com/engine/reference/builder/

ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION}
MAINTAINER Kamal Advani <kamal.advani@namingcrisis.net>

ARG HUGO_VERSION
ARG PYGMENTS_VERSION

ENV LAST_UPDATED 2018-09-01_19-35

#
# Update Alpine Packages
#
RUN apk update


#
# Install required Packages
#

# curl
RUN apk add curl

# pygments
RUN apk add py-pygments

# Get the Hugo package, and store it in tmp
RUN curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz > /tmp/hugo.tar.gz

# Now trash curl, to reduce size
RUN apk del curl

# Clean-up Alpine Packages
RUN rm -rf /var/cache/apk/*


#
# Unpack and Setup
#

# Directly extract binary to /usr/local/bin
RUN tar xf /tmp/hugo.tar.gz -C /usr/local/bin


EXPOSE 1313 9000 9001 9007 9011
VOLUME /data
WORKDIR /data
ENTRYPOINT ["/usr/local/bin/hugo"]
