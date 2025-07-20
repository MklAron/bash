#!/bin/bash

if [ -z "$1" ]; then
    echo "[i] Use: $0 <IP / domain>"
    exit 1
fi

target=$1
wordlist="/usr/share/dirb/wordlists/common.txt"

if [ ! -f "$wordlist" ]; then
    echo "[x] Error! Wordlist: $wordlist not found."
    exit 1
fi

dirb "$target" "$wordlist" -r