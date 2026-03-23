#!/usr/bin/env bash


# Thresholds
DISK_WARN=70
DISK_CRITICAL=90

MEMORY_WARN=80
MEMORY_CRITICAL=95

CPU_WARN=70
CPU_CRITICAL=90

LOGIN_WARN=10

ZOMBIE_WARN=1
ZOMBIE_CRITICAL=5

LARGE_FILE_SIZE="+1G"
DIRS_TO_CHECK=("$HOME" "/var/log" "/tmp")

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

main() {
    echo "======================================================================================"
    echo " syshealth report"
    echo " $(date '+%Y-%m-%d %H:%M:%S')"
    echo " $(hostname)"
    echo "======================================================================================"

    # Source all checks
    source "$SCRIPT_DIR/checks/disk.sh"
    source "$SCRIPT_DIR/checks/memory.sh"
    source "$SCRIPT_DIR/checks/cpu.sh"
    source "$SCRIPT_DIR/checks/services.sh"
    source "$SCRIPT_DIR/checks/logins.sh"
    source "$SCRIPT_DIR/checks/zombies.sh"
    source "$SCRIPT_DIR/checks/large_files.sh"

    # Run all checks
    check_disk
    check_memory
    check_cpu
    check_services
    check_logins
    check_zombies
    check_large_files

    echo ""
    echo "======================================================================================"
    echo " Report saved to: $LOG_FILE"
    echo "======================================================================================"
}

# Run with logging
main | tee >(sed $'s/\033\\[[0-9;]*m//g' >> "$LOG_FILE")
