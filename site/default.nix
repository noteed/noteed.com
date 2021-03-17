{ nixpkgs ? <nixpkgs>
}:

let
  pkgs = import nixpkgs {};
  lib = pkgs.lib;
  blog-version = "a5d83a246fc015a0230d8d8762ab1745c39399f9";
  blog = pkgs.fetchFromGitHub {
    owner = "noteed";
    repo = "blog";
    rev = blog-version;
    sha256 = "1xsdmqskv2l5pzka2prc6s9hknngnzz873b20s7ydzmd18s15n13";
  };

  not-os-version = "6ea8695956c75ec0a45ca64e38811dffb2bf518c";
  not-os = pkgs.fetchFromGitHub {
   owner = "noteed";
   repo = "not-os";
   rev = not-os-version;
   sha256 = "0n49i35x2jcirqi2w7qk5hbwi9z98xh3dnx3jr3gwzkw6lf1jq9g";
  };

  videos = ../../videos;

  design-system-version = "51694bea56d2e5c9545d88b35f11ccffbc536742";
  design-system = pkgs.fetchFromGitHub {
    owner = "hypered";
    repo = "design-system";
    rev = design-system-version;
    sha256 = "0wxvwwhj2xwhflnv02jffim4h6jgwziybv82z2mifmjczbvxhizn";
  };
  inherit (import design-system {}) template lua-filter replace-md-links static;

  to-html-with-metadata = src: metadata:
    pkgs.runCommand "html" {} ''
    ${pkgs.pandoc}/bin/pandoc \
      --from markdown \
      --to html \
      --standalone \
      --template ${template} \
      -M prefix="" \
      -M font="ibm-plex" \
      --lua-filter ${lua-filter} \
      --output $out \
      ${metadata} \
      ${src}
  '';

  to-html = src: to-html-with-metadata src ./metadata.yml;

  dirsToMds = dir:
    lib.mapAttrs'
      (n: v: if v == "regular" || v == "symlink"
             then lib.nameValuePair (lib.removeSuffix ".md" n) (dir + "/${n}")
             else lib.nameValuePair n (dirsToMds (dir + "/${n}")))
      (lib.filterAttrs
        (name: _: lib.hasSuffix ".md" name)
        (builtins.readDir dir));

in rec
{
  # nix-instanciate --eval --strict site/ -A md.index
  md.index = ../index.md;
  # TODO: Remove README.md and this shoule be ok.
  # md.blog = (dirsToMds (toString ../../blog));
  md.blog.index                   = (import blog).index;
  md.blog.expose-local-server     = (import blog).expose-local-server;
  md.blog.starting-with-nixops-1  = (import blog).starting-with-nixops-1;
  md.blog.starting-with-nixops-2  = (import blog).starting-with-nixops-2;
  md.not-os = ((import not-os {}).site {}).md;
  md.notes = (dirsToMds ../notes);
  md.videos = ((import videos).site {}).md;
  svg.videos = ((import videos).site {}).svg;

  # nix-build site/ -A html.index
  html.index = to-html md.index;
  html.blog = builtins.mapAttrs (_: v: to-html v) md.blog;
  html.not-os = builtins.mapAttrs (_: v: to-html v) md.not-os;
  html.notes = builtins.mapAttrs (_: v: to-html v) md.notes;
  html.videos = builtins.mapAttrs (_: v: to-html v) md.videos;

  html.all = pkgs.runCommand "all" {} ''
    mkdir -p $out/blog
    mkdir -p $out/not-os
    mkdir -p $out/notes
    mkdir -p $out/videos/01

    cp ${html.index} $out/index.html

    cp ${html.blog.index} $out/blog/index.html
    cp ${html.blog.expose-local-server} $out/blog/expose-local-server.html
    cp ${html.blog.starting-with-nixops-1} $out/blog/starting-with-nixops-1.html
    cp ${html.blog.starting-with-nixops-2} $out/blog/starting-with-nixops-2.html

    cp ${html.not-os.index} $out/not-os/index.html
    cp ${html.not-os.runvm} $out/not-os/runvm.html
    cp ${html.not-os.kernel} $out/not-os/kernel.html
    cp ${html.not-os.initrd} $out/not-os/initrd.html
    cp ${html.not-os.rootfs} $out/not-os/rootfs.html
    cp ${html.not-os.ext4} $out/not-os/ext4.html
    cp ${html.not-os.stage-1} $out/not-os/stage-1.html
    cp ${html.not-os.stage-2} $out/not-os/stage-2.html
    cp ${html.not-os.dist} $out/not-os/dist.html
    cp ${html.not-os.extra-utils} $out/not-os/extra-utils.html
    cp ${html.not-os.path} $out/not-os/path.html
    cp ${html.not-os.shrunk} $out/not-os/shrunk.html
    cp ${html.not-os.toplevel} $out/not-os/toplevel.html
    cp ${html.not-os.boot} $out/not-os/boot.html
    cp ${html.not-os.raw} $out/not-os/raw.html
    cp ${html.not-os.qcow2} $out/not-os/qcow2.html
    cp ${html.not-os.syslinux} $out/not-os/syslinux.html
    cp ${html.not-os.cmdline} $out/not-os/cmdline.html
    cp ${html.not-os.root-modules} $out/not-os/root-modules.html
    cp ${html.not-os.todo} $out/not-os/todo.html
    cp ${html.not-os.digital-ocean} $out/not-os/digital-ocean.html
    cp ${html.notes.psu} $out/notes/psu.html
    cp ${html.notes.mini} $out/notes/mini.html
    cp ${html.notes.til} $out/notes/til.html

    cp ${html.videos.index} $out/videos/index.html
    sed "s@url('../../images/fonts/@url('/static/fonts/@" ${svg.videos.title-01} > $out/videos/01/title.svg

    ${pkgs.bash}/bin/bash ${replace-md-links} $out
  '';

  inherit static;
}
