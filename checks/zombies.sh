check_zombies() {
    print_header "Zombie Processes"
    local zombie_list=$(ps aux | awk 'NR>1 && $8~/^Z/')
    local zombies=$(echo "$zombie_list" | grep -c "." || true)

    if [ "$zombies" -lt "$ZOMBIE_WARN" ]; then
        print_ok "No zombie processes"
    elif [ "$zombies" -lt "$ZOMBIE_CRITICAL" ]; then
        print_warn "$zombies zombie process(es) found:"
        echo "$zombie_list" | awk '{print "  - PID "$2": "$11}'
    else
        print_critical "$zombies zombie processes found:"
        echo "$zombie_list" | awk '{print "  - PID "$2": "$11}'
    fi
}
