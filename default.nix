{
  # Build with nix-build -A <attr>
  site = (import ./site).html.all;
}
