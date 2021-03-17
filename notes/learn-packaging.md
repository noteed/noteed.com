---
title: Learn packaging
---

Learn how to create, store and deploy packages (e.g. `.rpm` or `.deb`) for your
Linux distribution of choice.

<hr class="bt bb-0 br-0 bl-0 mh0 mt4 pb4 w4 bw1 b--black" />

## E.g., compared to Docker

Writing a recipe to build a `.deb` is not much different than writing a
Dockerfile. The result is easier to manipulate though (e.g. share packages on a
static web server, package managers are made to list available updates, apply
them, show package details, ...).

If you're a Docker user, you may need to provision your host machine with
docker-engine, but also with your own configuration files and scripts. Packages
can also create the right directories and permissions before hand.

Most Dockerfile will use `apt install` or `apk add` to add packages to an
image. In effect you rely on traditional package managers. Haven't you ever
wished you had your own apt cache to avoid breacking a `docker build` while
your Debian mirror was down ?

<hr class="bt bb-0 br-0 bl-0 mh0 mt4 pb4 w4 bw1 b--black" />

Related: <a href="static-binaries.html">Static binaries</a>
