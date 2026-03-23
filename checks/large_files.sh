check_large_files() {
    print_header "Large Files (>${LARGE_FILE_SIZE})"
    local found=0

    for dir in "${DIRS_TO_CHECK[@]}"; do
        local file_list
        file_list=$(find "$dir" -type f -size "$LARGE_FILE_SIZE" 2>/dev/null)
        if [ -n "$file_list" ]; then
            found=1
            print_warn "Large files found in $dir:"
            while IFS= read -r file; do
                du -sh "$file" 2>/dev/null | while read -r size path; do
                    echo "  - $size $path"
                done
            done <<< "$file_list"
        fi
    done

    if [ "$found" -eq 0 ]; then
        print_ok "No large files found"
    fi
}
