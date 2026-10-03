#!/bin/bash

while IFS= read -r line; do
	if echo "@$line" | grep -qw 'bin'; then
		echo "$line" >&2
	fi
done
