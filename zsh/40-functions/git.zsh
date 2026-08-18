# Git helpers.

#   push-first: push the first commit after the default branch to a new remote
#   branch named after that commit's message, slugified. Auto-detects which of
#   develop, main, or master the remote actually uses.
push-first() {
  local base_branch ref title slug

  if git rev-parse --verify origin/develop &>/dev/null; then
    base_branch="origin/develop"
  elif git rev-parse --verify origin/main &>/dev/null; then
    base_branch="origin/main"
  elif git rev-parse --verify origin/master &>/dev/null; then
    base_branch="origin/master"
  else
    echo "Error: Could not find origin/develop, origin/main, or origin/master" >&2
    return 1
  fi

  ref=$(git rev-list --reverse "$(git merge-base "$base_branch" HEAD)..HEAD" | head -1)
  if [[ -z "$ref" ]]; then
    echo "Error: No commits found after $base_branch" >&2
    return 1
  fi

  title=$(git log -1 --format="%s" "$ref")
  slug=$(echo "$title" \
    | tr '[:upper:]' '[:lower:]' \
    | sed 's/[^a-z0-9]/-/g; s/-\+/-/g; s/^-//; s/-$//')

  echo "Pushing $ref to refs/heads/$slug"
  git push origin "${ref}:refs/heads/${slug}"
}
