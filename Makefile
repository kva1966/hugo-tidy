# Copyright 2017 Marc-Antoine Ruel. All rights reserved.
# Use of this source code is governed under the Apache License, Version 2.0
# that can be found in the LICENSE file.

# Override these at the command like, like "make push HUGO_VERSION=0.20 REPO=user/repo".
HUGO_VERSION?=0.48
PYGMENTS_VERSION?=2.2.0
ALPINE_VERSION?=3.8
REPO?=kva1966/hugo-tidy

all: push

.PHONY: build push

build:
	docker build --build-arg "ALPINE_VERSION=${ALPINE_VERSION}" --build-arg "HUGO_VERSION=${HUGO_VERSION}" --build-arg "PYGMENTS_VERSION=${PYGMENTS_VERSION}" --tag ${REPO}:latest .

push: build
	docker tag ${REPO}:latest ${REPO}:hugo-${HUGO_VERSION}-pygments-${PYGMENTS_VERSION}
	docker push ${REPO}:hugo-${HUGO_VERSION}-pygments-${PYGMENTS_VERSION}
	docker push ${REPO}:latest
