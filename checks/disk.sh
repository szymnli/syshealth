check_disk() {
    print_header "Disk Usage"
    df -h --exclude-type=tmpfs --exclude-type=efivarfs --exclude-type=devtmpfs | awk 'NR>1 && !seen[$1]++ {print $5, $3, $2, $6}' | while read -r usage used total mount; do
       # Strip % sign
        usage=$(echo "$usage" | tr -d '%')
        if [ "$usage" -lt "$DISK_WARN" ]; then
            print_ok "$mount — ${used} / ${total} (${usage}%)"
        elif [ "$usage" -lt "$DISK_CRITICAL" ]; then
            print_warn "$mount — ${used} / ${total} (${usage}%) above ${DISK_WARN}%"
        else
            print_critical "$mount — ${used} / ${total} (${usage}%) above ${DISK_CRITICAL}%"
        fi
    done
}
