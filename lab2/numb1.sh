#!/bin/bash

LOG=/tmp/run.log
touch "$LOG"

prev=$(wc -l < "$LOG")
date '+%Y-%m-%d %H:%M:%S' >> "$LOG"

echo "Hello, World!"
echo "Количество предыдущих запусков: $prev" >&2
