---
title: TIL
date: 2020-07-08
---

# 2020-07-18

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
