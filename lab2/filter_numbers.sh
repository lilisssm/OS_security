#!/bin/bash

cnt=0

for arg in "$@"; do
	cnt=$((cnt + 1))
	if ((arg%3 == 0)); then
		continue
	fi
	if ((arg%2 == 0)); then
		echo "$arg" >> even.txt
	else
		echo "$arg" >> odd.txt
	fi
done
echo "Количество обработанных: $cnt"
