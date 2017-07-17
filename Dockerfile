# Copyright 2017 Kamal Advani. All rights reserved.
# Use of this source code is governed under the Apache License, Version 2.0
# that can be found in the LICENSE file.
#
# Doc: https://docs.docker.com/engine/reference/builder/

# TODO(make): Use ALPINE_VERSION, should be soon: https://github.com/docker/docker/issues/18119
FROM alpine:3.6
MAINTAINER Kamal Advani <kamal.advani@namingcrisis.net>

ARG HUGO_VERSION
ARG PYGMENTS_VERSION

# Update Alpine Packages
RUN apk update

# pygments
RUN apk add py-pygments

# Clean-up Alpine Packages
RUN rm -rf /var/cache/apk/*

# Note: https://docs.docker.com/engine/reference/builder/#add
# However, ADD seems to be decompressing remote URLs here!
# Docker Version:      17.06.0-ce
# The tar.gz file unpacks the 'hugo' binary directly to the folder.
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz /usr/local/bin

EXPOSE 1313 9000 9001 9007 9011
VOLUME /data
WORKDIR /data
ENTRYPOINT ["/usr/local/bin/hugo"]
