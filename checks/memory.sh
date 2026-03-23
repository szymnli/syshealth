check_memory() {
    print_header "Memory Usage"

    local used=$(free -m | awk '/Mem:/ {print $3}')
    local total=$(free -m | awk '/Mem:/ {print $2}')
    local percent_used=$((used * 100 / total))

    if [ "$percent_used" -lt "$MEMORY_WARN" ]; then
        print_ok "Memory usage: ${used} MB / ${total} MB ($percent_used%)"
    elif [ "$percent_used" -lt "$MEMORY_CRITICAL" ]; then
        print_warn "Memory usage is high: ${used} MB / ${total} MB ($percent_used%)"
    else
        print_critical "Memory usage is critical: ${used} MB / ${total} MB ($percent_used%)"
    fi
}
