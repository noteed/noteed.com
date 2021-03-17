---
title: Static binaries
---

If you consider adopting a programming language, consider one where you can
create statically-linked executables. This makes things so much easier.

<hr class="bt bb-0 br-0 bl-0 mh0 mt4 pb4 w4 bw1 b--black" />

## E.g., compared to Docker

With a statically-linked binary, provisioning a program on a remote host is
just uploading it.  With Docker, you need to install and maintain
docker-engine. Ideally you should have a nice way to provision the remote host
with Docker, but then, why not use that nice way to provision other stuff
directly ?

Docker is much more than packaging, but it seems a lot of people use it for
that purpose.

By the way, statically-linked executables make building Docker images a breeze.

If you use Docker to deploy, you probably want a private registry, which is
another piece to maintain. Static binaries are trivial to host on a static
site. Or to mirror. And so on. Simplicity goes a long way.

<hr class="bt bb-0 br-0 bl-0 mh0 mt4 pb4 w4 bw1 b--black" />

See also: [In praise of simplicity](http://www.matthieuricard.org/en/blog/posts/in-praise-of-simplicity)

<hr class="bt bb-0 br-0 bl-0 mh0 mt4 pb4 w4 bw1 b--black" />

Related: <a href="learn-packaging.html">Learn packaging</a>
