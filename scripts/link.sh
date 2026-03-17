#!/usr/bin/env bash

# This script creates symbolic links for files ending with `.symlink`,
# then runs all `after.sh` scripts in this repository.

set -eu
set -o pipefail

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)
FIND_SEARCH_DEPTH=4
TIMESTAMP=$(date +%Y%m%d%H%M%S)

global_opt=

function print() {
  local fmt="$1"
  shift
  printf "\033[0;35mscripts/link: \033[0m$fmt" "$@"
}

function create_symlink() {
  local src=$1 dst=$2
  local opt=${global_opt:-"undefined"}

  if [[ -L "$dst" || -e "$dst" ]] && [[ "$(readlink "$dst" 2>/dev/null || true)" == "$src" ]]; then
    opt="already_created"
  fi

  if [[ -L "$dst" || -e "$dst" ]] && [[ "$opt" == "undefined" ]]; then
    while :; do
      print "File already exists: %s\n" "$dst"
      print " [s]kip, [o]verwrite,[b]ackup?: "
      # Add '|| true' to avoid exiting with Ctrl+D
      read -r ans || true
      case "$ans" in
      [oO])
        opt="overwrite"
        break
        ;;
      [bB])
        opt="backup"
        break
        ;;
      [sS])
        opt="skip"
        break
        ;;
      "") ;;
      *)
        echo "Invalid option: $ans"
        ;;
      esac
    done
  fi

  if [[ "$opt" == "undefined" ]]; then
    # Some after.sh require that symbolic links are properly created.
    opt="create"
  fi

  if [[ "$opt" == "already_created" ]]; then
    return
  fi

  if [[ "$opt" == "skip" ]]; then
    print "Skip creating link: %s -> %s\n" "$dst" "$src"
    return
  fi

  if [[ "$opt" == "backup" ]]; then
    mv "$dst" "${dst}.bak.${TIMESTAMP}"
    print "Backed up: ${dst} -> ${dst}.bak.${TIMESTAMP}\n"
  fi

  if [[ "$opt" == "overwrite" ]]; then
    print "Overwrite: ${dst}\n"
    rm -rf "$dst"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -sv "$src" "$dst"
}

# Resolve args
if [ "$#" -gt 1 ]; then
  print "Select one of \"--overwrite\", \"--skip\", or \"--backup\" or don't select any\n"
  exit 1
fi

# ★ ${1:-} に変更
case "${1:-}" in
"--overwrite")
  global_opt="overwrite"
  ;;
"--skip")
  global_opt="skip"
  ;;
"--backup")
  global_opt="backup"
  ;;
"") ;;
*)
  print "Unknown option: $1\n"
  exit 1
  ;;
esac

# Create symbolic links
print "Create symbolic links\n"

while IFS= read -u 3 -r src; do
  left_trimmed=${src#"${DOTFILES_ROOT}/"}
  dst="$HOME/${left_trimmed%.symlink}"
  create_symlink "$src" "$dst"
done 3< <(find -H "$DOTFILES_ROOT" -maxdepth $FIND_SEARCH_DEPTH -name '*.symlink' -not -path '*.git*')

print "Symbolic links created (or already set).\n"

# Run after script
print "Run after hook scripts\n"

while IFS= read -u 3 -r src; do
  bash "$src" </dev/tty
done 3< <(find -H "$DOTFILES_ROOT" -maxdepth $FIND_SEARCH_DEPTH -name 'after.sh' -not -path '*.git*')

print "After scripts ran\n"
print "Done\n"
