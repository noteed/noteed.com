{ nixpkgs ? <nixpkgs>
}:

let
  pkgs = import nixpkgs {};
  lib = pkgs.lib;

  design-system-version = "da8585ecaa62c00d5e32b490581ef41ee09d79d5";
  design-system = pkgs.fetchFromGitHub {
    owner = "hypered";
    repo = "design-system";
    rev = design-system-version;
    sha256 = "1za6hf9ba7wvd0d2y4g0zn7vnvkfqmhpgq5sipc7yj7cxq24b941";
  };
  inherit (import design-system {}) template lua-filter replace-md-links static;

  to-metadata = src: pkgs.runCommand "yml" { buildInputs = [ pkgs.git ]; } ''
    export GIT_DIR=${builtins.path { path = ../.git; name = "git"; } }
    ${../scripts/git-file-to-metadata.sh} \
      "${lib.removePrefix (toString ../. + "/") (toString src)}" > $out
    cat ${./metadata.yml} >> $out
  '';

  to-html-with-metadata = src: metadata:
    pkgs.runCommand "html" {} ''
    ${pkgs.pandoc}/bin/pandoc \
      --from markdown \
      --to html \
      --standalone \
      --template ${../template.html} \
      -M prefix="" \
      -M font="ibm-plex" \
      --lua-filter ${lua-filter} \
      --output $out \
      ${metadata} \
      ${src}
  '';

  to-html = src: to-html-with-metadata src ./metadata.yml;

  to-html-with-git-metadata = src:
    let metadata = to-metadata src; in to-html-with-metadata src metadata;

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
  md.blog.index                   = ../../blog/index.md;
  md.blog.expose-local-server     = ../../blog/expose-local-server.md;
  md.blog.starting-with-nixops-1  = ../../blog/starting-with-nixops-1.md;
  md.blog.starting-with-nixops-2  = ../../blog/starting-with-nixops-2.md;
  md.not-os = (import ../../not-os/site {}).md;
  md.notes = (dirsToMds ../notes);

  # nix-build site/ -A html.index
  html.index = to-html md.index;
  html.blog = builtins.mapAttrs (_: v: to-html v) md.blog;
  html.not-os = builtins.mapAttrs (_: v: to-html v) md.not-os;
  html.notes = builtins.mapAttrs (_: v: to-html-with-git-metadata v) md.notes;

  html.all = pkgs.runCommand "all" {} ''
    mkdir -p $out/blog
    mkdir -p $out/not-os
    mkdir -p $out/notes
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
    ${pkgs.bash}/bin/bash ${replace-md-links} $out
  '';

  inherit static;
}
