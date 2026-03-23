check_services() {
    print_header "Failed Services"

    local num_services=$(systemctl --failed --no-legend | wc -l)

    if [ "$num_services" -gt 1 ]; then
        print_critical "$num_services failed services:"
        systemctl --failed --no-legend | awk '{print "  - "$2}'
    elif [ "$num_services" -eq 1 ]; then
        print_warn "1 failed service:"
        systemctl --failed --no-legend | awk '{print "  - "$2}'
    else
        print_ok "No failed services"
    fi
}
