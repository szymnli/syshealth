check_logins() {
    print_header "Failed Logins"
    local failed_lines=$(journalctl _SYSTEMD_UNIT=sshd.service --since today --no-pager | grep "Failed password")
    local failed_logins=$(echo "$failed_lines" | grep -c "Failed password" || true)

    if [ "$failed_logins" -eq 0 ]; then
        print_ok "No failed logins today"
    elif [ "$failed_logins" -lt "$LOGIN_WARN" ]; then
        print_warn "$failed_logins failed logins today"
        echo "$failed_lines" | awk '{print $11}' | sort | uniq -c | sort -rn | while read -r count ip; do
            echo "  - $count attempts from $ip"
        done
    else
        print_critical "$failed_logins failed logins today"
        echo "$failed_lines" | awk '{print $11}' | sort | uniq -c | sort -rn | while read -r count ip; do
            echo "  - $count attempts from $ip"
        done
    fi
}
