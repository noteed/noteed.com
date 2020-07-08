---
title: TIL
date: 2020-07-08
---

# 2020-07-08

- I have created an account at Packet, and have launched a small NixOS
  instance, just to have a look (and promptly deleted it; bare metal is quite
  expensive). I'd like to run an on-demand bare metal machine to run CI jobs
  that require VMs (e.g. some Nix build when building VM images), possibly
  driven by a GitHub Actions workflow (Packet-related actions do exist).

# 2020-07-04

- I have written a small `.github/worflows` file. It uses my `design-system`
  repository to build an HTML file and publish it to GitHub Pages.
  [More](https://github.com/noteed/actions).
- I have started to play with Datasette. I have written a small script to
  export some Git commits into a SQLite database, and created a custom
  Datasette Docker image to support HTML links (using the `datasette-json-html`
  plugin). 
