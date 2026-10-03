#!/bin/bash

DIR=${1:-.}
TMP=/tmp/hashes_$$.txt

find "$DIR" -maxdepth 1 -type f -exec md5sum {} \; | sort > "$TMP"
dup=$(cut -d' ' -f1 "$TMP" | uniq -d)

if [ -z "$dup" ]; then
	echo "Нет дубликатов."
	rm -f "$TMP"
	exit 0
fi

for h in $dup; do
	files=$(grep "^$h " "$TMP" | awk '{print $2}')
	cnt=$(echo "$files" | wc -l)
	echo "Количество дубликатов: $cnt"
	echo "$files"
done
rm -f "$TMP"
