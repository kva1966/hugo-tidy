# Hugo with Pygments Docker Image

[Hugo](https://gohugo.io/), colorize code via [Pygments](http://pygments.org/).

Forked from <https://github.com/maruel/hugo-tidy>, with the following changes:

* Only runs `hugo`, in the local directory which must match the standard Hugo 
    directory structure. Pass on any further options on the commandline.
* No minification, no gzipping.
* Exposes ports 1313 (Hugo default), 9000, 9001, 9007, and 9011 as some choices 
    for `hugo server -p <port>`
* Remove Alpine Linux version from tag.

Basically, just a self-contained Hugo with Pygments wrapper. Got tired of my Linux
distribution's packages going out of date and just generally messing up.


## Sample Run

Docker Registry entry is [here](https://hub.docker.com/r/kva1966/hugo-tidy/).

Sample configuration for ease of use in bashrc or profile:

```
export HUGO_DOCKER_IMAGE=kva1966/hugo-tidy:hugo-0.48-pygments-2.2.0

docker_run_with_uid() {
  docker run --rm -u $(id -u):$(id -g) $@
}

export -f docker_run_with_uid


hugo() {
  docker_run_with_uid -v $(pwd):/data $HUGO_DOCKER_IMAGE $@
}

export -f hugo


hugoserve() {
  docker_run_with_uid -v $(pwd):/data -p 1313:1313 $HUGO_DOCKER_IMAGE server --bind 0.0.0.0 $@
}

export -f hugoserve
```

Using the container with previously defined shell functions:

```
cd site-directory/
hugo
hugo-server
```


## Making your own

Override `HUGO_VERSION`, `PYGMENTS_VERSION` to select newer versions.

Override `REPO` to have it push to your repository.

To push an image on your name with a new version of Hugo, run the following:
```
make push HUGO_VERSION=0.20 REPO=user/repo
```
