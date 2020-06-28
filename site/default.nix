{ nixpkgs ? <nixpkgs>
}:

let
  pkgs = import nixpkgs {};

  design-system-version = "da8585ecaa62c00d5e32b490581ef41ee09d79d5";
  design-system = pkgs.fetchFromGitHub {
    owner = "hypered";
    repo = "design-system";
    rev = design-system-version;
    sha256 = "1za6hf9ba7wvd0d2y4g0zn7vnvkfqmhpgq5sipc7yj7cxq24b941";
  };
  inherit (import design-system {}) template lua-filter replace-md-links static;

  to-html = src: pkgs.runCommand "html" {} ''
    ${pkgs.pandoc}/bin/pandoc \
      --from markdown \
      --to html \
      --standalone \
      --template ${template} \
      -M prefix="" \
      -M font="ibm-plex" \
      --lua-filter ${lua-filter} \
      --output $out \
      ${./metadata.yml} \
      ${src}
  '';

in rec
{
  md.index = ../index.md;
  md.blog.index                   = ../../blog/index.md;
  md.blog.expose-local-server     = ../../blog/expose-local-server.md;
  md.blog.starting-with-nixops-1  = ../../blog/starting-with-nixops-1.md;
  md.blog.starting-with-nixops-2  = ../../blog/starting-with-nixops-2.md;
  md.not-os = (import ../../not-os/site {}).md;

  html.index = to-html md.index;
  html.blog.index                   = to-html md.blog.index;
  html.blog.expose-local-server     = to-html md.blog.expose-local-server;
  html.blog.starting-with-nixops-1  = to-html md.blog.starting-with-nixops-1;
  html.blog.starting-with-nixops-2  = to-html md.blog.starting-with-nixops-2;
  html.not-os.index = to-html md.not-os.index;
  html.not-os.runvm = to-html md.not-os.runvm;
  html.not-os.initrd = to-html md.not-os.initrd;
  html.not-os.kernel = to-html md.not-os.kernel;
  html.not-os.rootfs = to-html md.not-os.rootfs;
  html.not-os.ext4 = to-html md.not-os.ext4;
  html.not-os.stage-1 = to-html md.not-os.stage-1;
  html.not-os.stage-2 = to-html md.not-os.stage-2;
  html.not-os.dist = to-html md.not-os.dist;
  html.not-os.extra-utils = to-html md.not-os.extra-utils;
  html.not-os.path = to-html md.not-os.path;

  html.all = pkgs.runCommand "all" {} ''
    mkdir -p $out/blog
    mkdir -p $out/not-os
    cp ${html.index} $out/index.html
    cp ${html.blog.index} $out/blog/index.html
    cp ${html.blog.expose-local-server} $out/blog/expose-local-server.html
    cp ${html.blog.starting-with-nixops-1} $out/blog/starting-with-nixops-1.html
    cp ${html.blog.starting-with-nixops-2} $out/blog/starting-with-nixops-2.html
    cp ${html.not-os.index} $out/not-os/index.html
    cp ${html.not-os.runvm} $out/not-os/runvm.html
    cp ${html.not-os.initrd} $out/not-os/initrd.html
    cp ${html.not-os.kernel} $out/not-os/kernel.html
    cp ${html.not-os.rootfs} $out/not-os/rootfs.html
    cp ${html.not-os.ext4} $out/not-os/ext4.html
    cp ${html.not-os.stage-1} $out/not-os/stage-1.html
    cp ${html.not-os.stage-2} $out/not-os/stage-2.html
    cp ${html.not-os.dist} $out/not-os/dist.html
    cp ${html.not-os.extra-utils} $out/not-os/extra-utils.html
    cp ${html.not-os.path} $out/not-os/path.html
    ${pkgs.bash}/bin/bash ${replace-md-links} $out
  '';

  inherit static;
}
