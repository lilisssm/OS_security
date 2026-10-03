#!/bin/bash

verbose=0
outfile=""

usage() {
	cat <<EOF
Использование: $0 [-h] [-v] [-o file] операция числа...
Операции:
  add  — сложение
  sub  — вычитание
  mul  — умножение
  div  — деление
  pow  — возведение в степень
EOF
}

while getopts "hvo:" opt; do
	case $opt in
		h) usage; exit 0;;
		v) verbose=1 ;;
		o) outfile="$OPTARG" ;;
		*) usage; exit 1 ;;
	esac
done
shift $((OPTIND - 1))
op="$1"
shift
nums=("$@")

if [ -z "$op" ] || [ ${#nums[@]} -eq 0 ]; then
	echo "Укажите операцию и число" >&2
	usage
	exit 1
fi

res=${nums[0]}

for n in "${nums[@]:1}"; do
	case $op in
		add) res=$((res + n)) ;;
		sub) res=$((res - n)) ;;
		mul) res=$((res * n)) ;;
		div)
			if [ "$n" -eq 0 ]; then
				echo "Деление на ноль" >&2
				exit 1
			fi
			res=$((res / n))
			;;
		pow) res=$((res ** n)) ;;
		*) echo "Неизвестная опeрция: $op" >&2; exit 1 ;;
	esac
	[ "$verbose" -eq 1 ] && echo ": $n -> $res" >&2
done

if [ -n "$outfile" ]; then
	echo "$res" > "$outfile"
	[ "$verbose" -eq 1 ] && echo "Записано в $outfile" >&2
else
	echo "$res"
fi


