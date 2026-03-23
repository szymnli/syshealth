check_cpu() {
    print_header "CPU Usage"

    # First reading
    local cpu1=$(grep '^cpu ' /proc/stat)
    sleep 0.5

    # Second reading
    local cpu2=$(grep '^cpu ' /proc/stat)

    # Extract idle values
    local idle1=$(echo "$cpu1" | awk '{print $5}')
    local idle2=$(echo "$cpu2" | awk '{print $5}')

    # Extract total values
    local total1=$(echo "$cpu1" | awk '{print $2+$3+$4+$5+$6+$7+$8+$9}')
    local total2=$(echo "$cpu2" | awk '{print $2+$3+$4+$5+$6+$7+$8+$9}')

    # Calculate usage percentage
    local percent=$(awk "BEGIN {
        idle=$idle2-$idle1
        total=$total2-$total1
        printf \"%d\", (1 - idle/total) * 100
    }")

    # Compare and print
    if [ "$percent" -lt "$CPU_WARN" ]; then
        print_ok "CPU usage: ${percent}%"
    elif [ "$percent" -lt "$CPU_CRITICAL" ]; then
        print_warn "CPU usage is high: ${percent}%"
    else
        print_critical "CPU usage is critical: ${percent}%"
    fi
}
