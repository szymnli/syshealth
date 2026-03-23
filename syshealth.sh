#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
LOG_DIR="$SCRIPT_DIR/logs"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/syshealth_$TIMESTAMP.txt"

mkdir -p "$LOG_DIR"

# Helper functions
print_header() {
    echo -e "\n\033[1;34m==== $1 ====\033[0m"
}

print_ok() {
    echo -e "\033[32m[OK]\033[0m $1"
}

print_warn() {
    echo -e "\033[33m[WARN]\033[0m $1"
}

print_critical() {
    echo -e "\033[31m[CRITICAL]\033[0m $1"
}
