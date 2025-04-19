#!/usr/bin/env bash

LOG_LEVEL="DEBUG"

log() {
    local level="$1"
    local message="$2"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    declare -A levels=(["DEBUG"]=0 ["INFO"]=1 ["WARN"]=2 ["ERROR"]=3)
    
    if [[ ${levels[$level]} -ge ${levels[$LOG_LEVEL]} ]]; then
        echo "DOTS | [$timestamp] [$level] $message"
    fi
}

check_install() {
    local package="$1"
    log "INFO" "Starting installation of package: $package"

    update

    # check if the package is already installed
    if command -v "$package" &> /dev/null; then
        log "INFO" "$package is already installed. Skipping installation."
        return 0
    fi
    
    apt-get install -y "$package" 2>&1 | while IFS= read -r line; do
        log "DEBUG" "$line"
    done
    if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
        log "INFO" "Successfully installed package: $package"
    else
        log "ERROR" "Failed to install package: $package"
    fi
}

update() {
    log "INFO" "Starting apt update"
    apt-get update 2>&1 | while IFS= read -r line; do
        log "DEBUG" "$line"
    done
    if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
        log "INFO" "Successfully updated package list"
    else
        log "ERROR" "Failed to update package list"
    fi
}

upgrade() {
    log "INFO" "Starting apt upgrade"
    update
    apt-get upgrade -y 2>&1 | while IFS= read -r line; do
        log "DEBUG" "$line"
    done
    if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
        log "INFO" "Successfully upgraded packages"
    else
        log "ERROR" "Failed to upgrade packages"
    fi
}

# 引数のファイルorディレクトリについて $HOME/.config/ にシンボリックリンクを作成する
# dotfiles/.config/git が引数なら、$HOME/.config/git を作成する

create_symlink() {
    local source_path="$1"
    local item_name=$(basename "$source_path")
    local target="$2"

    # Ensure the source path exists
    if [ ! -e "$source_path" ]; then
        log "ERROR" "Source path $source_path does not exist."
        return 1
    fi

    # Ensure the target directory exists
    if [ ! -d "$HOME/.config" ]; then
        log "INFO" "Target directory $HOME/.config does not exist. Creating it."
        mkdir -p "$HOME/.config"
    fi

    # Backup existing files or directories if they exist
    if [ -e "$target" ]; then
        log "INFO" "Backing up existing $target to $target.bak"
        mv "$target" "$target.bak"
    fi

    # Create symlink
    log "INFO" "Creating symlink for $item_name"
    ln -s "$source_path" "$target"
    log "INFO" "Symlink created successfully for $item_name"
}
