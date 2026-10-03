#!/bin/bash

all_bytes=0
all_lines=0
cnt=0

files=$(find "$HOME" -maxdepth 1 -type f -name '*.txt')
echo "Все .txt файлы:"
for f in $files; do
	echo "	$f"
	bytes=$(wc -c < "$f")
	lines=$(wc -l < "$f")
	all_bytes=$((all_bytes + bytes))
	all_lines=$((all_lines + lines))
	cnt=$((cnt + 1))
done

echo "Количество файлов: $cnt"
echo "Размер всех файлов: $all_bytes"
echo "Общее число строк во всех файлах: $all_lines"
