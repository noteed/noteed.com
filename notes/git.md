---
title: Git
---

Some rules of thumb:

- Don't use `git add .`. It will probably bite you into adding to much stuff --
  creating commits exaclty with what you want is a better habit to get.

- Don't use `git pull` to retrieve the content of shared branches. A typical
  example is to commit on a branch, try to push it to GitHub, which refuse the
  push because it is not a fast-forward one. If you simply pull, you'll create a
  merge commit, which is probably not needed.
  <br />
  Instead, use something like `git fetch` and `rebase`. You can also use `git
  pull --ff-only` to "tentatively" pull, i.e. fail if it is not a fast forward
  (in that case the remote tracking branch is already updated locally).

- Before creating a new commit, use `git status` and `git diff` to decide what
  to commit. Adding a `-v` flag to `git commit` is also an option to review
  what you are committing.

- Before pushing a set of commits to GitHub, use `git log` and its variants
  (e.g. `-p` or `--graph`) to review what you will share.

Some rules above could be rephrased as: use commands that have the precise
result you want (instead of commands with multiple kinds of results). Or:
double check that what you want to persist in the history, and share with
others, are really what you wanted.
