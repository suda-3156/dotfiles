#!/usr/bin/env bash

# log
# Log messages with different severity levels
# Arguments:
#   level: The severity level of the log message (DEBUG, INFO, WARN, ERROR)
#   message: The log message to display
# Usage:
#   log level message

# realtime_log
# Execute a command and log its output in real-time
# Arguments:
#   command: The command to execute
# Usage:
#   realtime_log command
# Example:
#   realtime_log "ping google.com"

set -eu

LOG_LEVEL="INFO"

SOURCE_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

LOG_OUT="$SOURCE_DIR/../../../stdout.log"
# LOG_ERR=./stderr.log

# exec 1> >(
#     while read -r line; do echo "$line"; done \
#         | tee -a $LOG_OUT
# )

# exec 2> >(
#     while read -r line; do echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $line"; done \
#         | tee -a $LOG_ERR $LOG_OUT >&2
# )

function log() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    declare -A levels=(["DEBUG"]=10 ["INFO"]=20 ["WARN"]=30 ["ERROR"]=40)
    declare -A colors=(
        ["DEBUG"]="\033[0;37m"   # Gray
        ["INFO"]="\033[0;34m"    # Blue
        ["WARN"]="\033[0;33m"    # Yellow
        ["ERROR"]="\033[0;31m"   # Red
    )
    local reset="\033[0m"

    if [[ ${levels[$level]} -ge ${levels[$LOG_LEVEL]} ]]; then
        local colored_level="${colors[$level]}[$level]${reset}"
        local colored_log="$timestamp $colored_level $message"
        local plain_log="$timestamp [$level] $message"

        echo -e "$colored_log"   # 色付きでコンソール出力
        echo "$plain_log" >> "$LOG_OUT"  # 色なしでファイル出力
    fi
}

function realtime_log() {
    local command="$1"
    
    { eval $command; } 2>&1 | while IFS= read -r line; do
        log "DEBUG" "$line"
    done

    if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
        log "INFO" "Successfully executed command: $command"
    else
        log "ERROR" "Failed to execute command: $command"
        return 1
    fi
}
