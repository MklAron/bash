#!/bin/bash
 echo "[i] Searching for files..."
result=$(find / -name "*.sh" -user root -perm -o=w -type f 2>/dev/null)

if [[ -z "$result" ]]; then
    echo "[x] No file found!"
else
    echo "[*] Files found:"
    echo "$result"
fi