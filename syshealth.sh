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

# Source all checks
source "$SCRIPT_DIR/checks/disk.sh"
source "$SCRIPT_DIR/checks/memory.sh"
source "$SCRIPT_DIR/checks/cpu.sh"
source "$SCRIPT_DIR/checks/services.sh"
source "$SCRIPT_DIR/checks/logins.sh"
source "$SCRIPT_DIR/checks/zombies.sh"


# Run all checks
check_disk
check_memory
check_cpu
check_services
check_logins
check_zombies
