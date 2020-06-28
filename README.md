# `noteed.com`


## Building

```
$ nix-build -A site
```


## Notes

The site built by this repository is included in
[nix-notes](https://github.com/noteed/nix-notes), which adds its own routes.

TODO: When built with nix-notes, the resulting VM contains Pandoc, GHC, the
not-os image, ... This should not be the case.
