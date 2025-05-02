#!/usr/bin/env bash

# Usage:
# distribution=$(get_distribution)
# echo "Detected distribution: $distribution"

set -eu

function get_distribution() {
    if [[ -e /etc/debian_version || -e /etc/debian_release ]]; then
        if [[ -e /etc/lsb-release ]]; then
            echo "ubuntu"
        else
            echo "debian"
        fi
        return
    fi

    if [[ -e /etc/fedora-release ]]; then
        echo "fedora"
        return
    fi

    if [[ -e /etc/redhat-release ]]; then
        if [[ -e /etc/oracle-release ]]; then
            echo "oracle"
        else
            echo "redhat"
        fi
        return
    fi

    if [[ -e /etc/arch-release ]]; then
        echo "arch"
        return
    fi

    echo "unknown"
}
