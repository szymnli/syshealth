check_disk() {
    print_header "Disk Usage"

    df -h | awk 'NR>1 {print $5, $6}' | while read -r usage mount; do
        # Strip % sign
        usage=$(echo "$usage" | tr -d '%')
        # Compare against DISK_WARN and DISK_CRITICAL
        if [ "$usage" -lt "$DISK_WARN" ]; then
            print_ok "$mount - ${usage}%"
        elif [ "$usage" -lt "$DISK_CRITICAL" ]; then
            print_warn "$mount - ${usage}% (above ${DISK_WARN}%)"
        else
            print_critical "$mount - ${usage}% (above ${DISK_CRITICAL}%)"
        fi
    done
}
