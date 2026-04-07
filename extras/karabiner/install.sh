#!/usr/bin/env bash

set -eu

function print() {
    local fmt="$1"
    shift
    printf "\033[0;36m karabiner: \033[0m$fmt" "$@"
}

if [[ "$(uname)" != "Darwin" ]]; then
    print "karabiner/install.sh - This script must be run on macOS."
    exit 0
fi

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TIMESTAMP=$(date +%Y%m%d%H%M%S)
CONFIG_FILE="$HOME/.config/karabiner/karabiner.json"

while :; do
    print "Install Karabiner Elements via Homebrew? (y/N): "
    read -r ans
    case "$ans" in
    [yY])
        print "Installing...\n"
        brew install --cask karabiner-elements
        break
        ;;
    "" | [nN])
        print "Skipping installation.\n"
        break
        ;;
    *)
        print "Invalid choice: '$ans'. Please enter [y]es or [n]o.\n"
        ;;
    esac
done

if ! command -v deno > /dev/null 2>&1; then
    print "Deno not installed. Following configuration requires deno. Skip.\n"
    exit 0
fi

print "Currently, setting up the configuration requires several steps.\n"
print "First, open Karabiner-Elements and select the ANSI keyboard.\n"
print "Next, run 'deno run build' to update karabiner.json.\n"
print "Finally, reopen Karabiner-Elements and configure the settings for each device.\n"

exit 0

# if [[ -L "$CONFIG_FILE" || -e "$CONFIG_FILE" ]]; then
#     while :; do
#         printf "File already exists: %s\nChoose action - [o]verwrite,\n [b]ackup, or [s]kip: " "$CONFIG_FILE"
#         read -r ans
#         case "$ans" in
#         [oO])
#             rm -rf "$CONFIG_FILE"
#             break
#             ;;
#         [bB])
#             print "Backed up: $CONFIG_FILE -> karabiner.json.bak.$TIMESTAMP\n"
#             mv "$CONFIG_FILE" "$CONFIG_FILE.bak.$TIMESTAMP"
#             break
#             ;;
#         [sS])
#             exit 0
#             ;;
#         "") ;;
#         *)
#             print "Invalid option: $ans\n"
#             ;;
#         esac
#     done
# fi
#
# cd "$DOTFILES_ROOT/extras/karabiner"
# deno run build
#
# print "Karabiner config setup completed.\n"
