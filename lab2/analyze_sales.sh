#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Использование: $0 <csv-файл>" >&2
    exit 1
fi

file="$1"
if [ ! -f "$file" ]; then
    echo "Файл $file не найден" >&2
    exit 1
fi

total=0
cnt=0
max=0
max_product=""
price_sum=0

while IFS=, read -r product price quantity; do
    [[ "$price" =~ ^[0-9]+$ ]] || continue
    [[ "$quantity" =~ ^[0-9]+$ ]] || continue

    sum=$((price * quantity))
    total=$((total + sum))
    price_sum=$((price_sum + price))
    cnt=$((cnt + 1))

    if [ "$price" -gt "$max" ]; then
        max=$price
        max_product="$product"
    fi
done < "$file"

if [ "$cnt" -eq 0 ]; then
    echo "Нет данных для обработки" >&2
    exit 1
fi

avg=$((price_sum / cnt))

{
    echo "Общая сумма продаж: $total"
    echo "Средняя стоимость продажи: $avg"
    echo "Самая дорогая продажа: $max ($max_product)"
} | tee sales_report.txt
