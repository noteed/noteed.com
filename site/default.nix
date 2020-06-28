{ nixpkgs ? <nixpkgs>
}:

let
  pkgs = import nixpkgs {};

  design-system-version = "4d55e94cf514d7e6bd65d6aae537c1d0a798894c";
  design-system = pkgs.fetchFromGitHub {
    owner = "hypered";
    repo = "design-system";
    rev = design-system-version;
    sha256 = "124szwc5mj12pbn8vc9z073bhwhyjgji2xc86jdafpi24d1dsqr4";
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

  html.index = to-html md.index;
  html.blog.index                   = to-html md.blog.index;
  html.blog.expose-local-server     = to-html md.blog.expose-local-server;
  html.blog.starting-with-nixops-1  = to-html md.blog.starting-with-nixops-1;
  html.blog.starting-with-nixops-2  = to-html md.blog.starting-with-nixops-2;

  html.all = pkgs.runCommand "all" {} ''
    mkdir -p $out/blog
    cp ${html.index} $out/index.html
    cp ${html.blog.index} $out/blog/index.html
    cp ${html.blog.expose-local-server} $out/blog/expose-local-server.html
    cp ${html.blog.starting-with-nixops-1} $out/blog/starting-with-nixops-1.html
    cp ${html.blog.starting-with-nixops-2} $out/blog/starting-with-nixops-2.html
    ${pkgs.bash}/bin/bash ${replace-md-links} $out
  '';

  inherit static;
}
