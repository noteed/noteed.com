
# Extract when a file has been added and last updated to a Git repository.
# (Actually, a file can be added multiple times, e.g. when merging mutliple
# histories. This takes the first occurence.)

FILE_PATH="$1"

# Exit if the file is not tracked by Git.
git ls-files --error-unmatch -- "${FILE_PATH}" > /dev/null 2>&1 || exit 0

CREATED=$(git log --diff-filter=A --reverse --format=format:'"%aI"' -- \
  "${FILE_PATH}" | head -n 1)
LAST_MODIFIED=$(git log -n 1 --format=format:'"%aI"' -- "${FILE_PATH}")

echo ---
echo "path: ${FILE_PATH}"
echo "created: ${CREATED}"
echo "updated: ${LAST_MODIFIED}"
echo ---
