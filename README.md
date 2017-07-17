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


# Sample Run

```
alias hugo=docker run --rm -u $(id -u):$(id -g) -v $(pwd):/data kva1966/hugo-tidy:hugo-0.25.1-alpine-3.6-pygments-2.2.0 
alias hugo-server=docker run --rm -u $(id -u):$(id -g) -v $(pwd):/data -p 1313:1313 kva1966/hugo-tidy:hugo-0.25.1-alpine-3.6-pygments-2.2.0 server --bind 0.0.0.0

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
