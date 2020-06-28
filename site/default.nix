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

  html.index = to-html md.index;
  html.all = pkgs.runCommand "all" {} ''
    mkdir $out
    cp ${html.index} $out/index.html
    ${pkgs.bash}/bin/bash ${replace-md-links} $out
  '';

  inherit static;
}
