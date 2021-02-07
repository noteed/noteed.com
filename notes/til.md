---
title: TIL
date: 2020-07-08
---

# 2020-10-31

- So I'm reading the installation instructions of Doom Emacs. Which means I
  have added emacs, ripgrep, and fd in my `configuration.nix`. I guess I'll
  quickly burn `rg` and `fd` in my fingers.

  I have followed the clone/install instructions, and answered yes to create
  the envvars file. Then it clones/builds a lot of stuff for a while...
  Then it asks you want to download icon fonts (yes).


# 2020-10-10

- I have installed Steam on my T480:
  https://gist.github.com/noteed/10c06677d686306e23a3259a3223294e.
- I have run the last line in
  https://github.com/svanderburg/nix-androidenvtests/tree/master/tests and
  ended up with an installable `.apk`.

I have changed the following to use a more recent API level:

```
buildPlatformVersions ? [ "28" ]
emulatePlatformVersions ? [ "28" ]
```

and

```
android:minSdkVersion="28"
android:targetSdkVersion="28"
```


# 2020-10-08

I have produced this Gist:
https://gist.github.com/noteed/db47709fe4869139a4a6453c2c9064d8 which shows how
to use CadQuery to produce an HTML page with an interactive 3D model. This uses
sphinx, and sphinxcadquery which seems simple enough to understand and turn
into a standalone HTML page builder.


# 2020-10-07

I have installed Syncthing on both my old NUC and my T480. On the NUC it is
installed through a (quite old) Nix, while my T480 runs NixOS and is
up-to-date. Syncing between the two worked like a charm.


# 2020-10-01

Bunch of links:

- Glamorous toolkit: https://gtoolkit.com/
- Eve: http://witheve.com/
- Drakon: http://drakon-editor.sourceforge.net/
- P programming language: https://github.com/p-org/P


# 2020-09-29

- I've read a bit about Soufflé, in particular its simple example, and the
  tutorial: https://souffle-lang.github.io/tutorial.


# 2020-09-28

- I've read a bit about Mercury and Picat.
- A few days ago, I read again about Shake (the build system).
- I completed Inspired, by Marty Cagan.


# 2020-08-08

- I have continued to learn about GitHub Actions. I forked the
  `backblaze-b2-sync` action to update it, and used it to upload the result of my
  noteed/actions build to B2. (Actually it's easier to directly use the `b2`
  command-line tool so it can read Nix `./result` symlink.
- I have setup an account to Backblaze.


# 2020-07-18

- You can navigate to `/new` on GitHub to create a new repository. This is
  nice.

Bunch of links:

- I stumbled upon a very interesting ["issue"
  thread](https://github.com/BrunoLevy/learn-fpga/issues/1) about a RISC-V
  softcore meant to run on a iCEstick, a small USB stick form factor board with a
  CE40HX-1k FPGA on it. There are a lot of nice links there.
- [Beginning FPGA
  development](https://www.mattvenn.net/2017/11/05/beginning-fpga/) is
  mentionned in the above thread.
- [ULX3s](https://www.crowdsupply.com/radiona/ulx3s) seems to be a nice FPGA
  development board, with 12k, 44k, and 84k LUT variants. There is also an
  ESP32 on it.
- [netlistsvg](https://github.com/nturley/netlistsvg) is a program to convert
  Yosys JSON netlist to SVG schematics. This makes me think to my Respan
  project (which is not related to FPGAs).

- I have written some Markdown tricks, as supported by GitHub [in this
  Gist](https://gist.github.com/noteed/54456694d7d778bbc2f7a2e7946755e9).

# 2020-07-08

- I have created an account at Packet, and have launched a small NixOS
  instance, just to have a look (and promptly deleted it; bare metal is quite
  expensive). I'd like to run an on-demand bare metal machine to run CI jobs
  that require VMs (e.g. some Nix build when building VM images), possibly
  driven by a GitHub Actions workflow (Packet-related actions do exist).

  I've played a bit with their nice command-line tool, recreating and deleting
  another "device". Their `device get` subcommand should state the "plan" (e.g
  c1.small.x86).

# 2020-07-04

- I have written a small `.github/worflows` file. It uses my `design-system`
  repository to build an HTML file and publish it to GitHub Pages.
  [More](https://github.com/noteed/actions).
- I have started to play with Datasette. I have written a small script to
  export some Git commits into a SQLite database, and created a custom
  Datasette Docker image to support HTML links (using the `datasette-json-html`
  plugin).
