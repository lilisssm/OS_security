#!/bin/bash

format="txt"
gen_sql=0

usage() {
    cat <<EOF
Использование: $0 [-f txt|csv] [-g] <csv-файл>
  -f csv   — вывести отчёт в формате CSV
  -g       — сгенерировать SQL для импорта в PostgreSQL
EOF
}

while getopts "f:g" opt; do
    case $opt in
        f) format="$OPTARG" ;;
        g) gen_sql=1 ;;
        *) usage; exit 1 ;;
    esac
done
shift $((OPTIND - 1))

file="$1"
if [ -z "$file" ] || [ ! -f "$file" ]; then
    echo "Ошибка: укажите существующий CSV-файл" >&2
    usage
    exit 1
fi

total=0
count=0
max=0
max_product=""
price_sum=0

while IFS=, read -r product price quantity; do
    [[ "$price" =~ ^[0-9]+$ ]] || continue
    [[ "$quantity" =~ ^[0-9]+$ ]] || continue

    sum=$((price * quantity))
    total=$((total + sum))
    price_sum=$((price_sum + price))
    count=$((count + 1))

    if [ "$price" -gt "$max" ]; then
        max=$price
        max_product="$product"
    fi
done < "$file"

if [ "$count" -eq 0 ]; then
    echo "Нет данных для обработки" >&2
    exit 1
fi

avg=$((price_sum / count))

# Вывод в выбранном формате
if [ "$format" = "csv" ]; then
    echo "total,avg,max,max_product" > sales_report10.csv
    echo "$total,$avg,$max,$max_product" >> sales_report10.csv
    echo "Отчёт сохранён в sales_report.csv"
else
    {
        echo "Общая сумма продаж: $total"
        echo "Средняя стоимость продажи: $avg"
        echo "Самая дорогая продажа: $max ($max_product)"
    } | tee sales_report10.txt
fi

# Генерация SQL
if [ "$gen_sql" -eq 1 ]; then
    cat > import.sql <<EOF
-- SQL для импорта sales_report в PostgreSQL
CREATE TABLE IF NOT EXISTS sales_report (
    id SERIAL PRIMARY KEY,
    total INT NOT NULL,
    avg INT NOT NULL,
    max INT NOT NULL,
    max_product VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO sales_report (total, avg, max, max_product)
VALUES ($total, $avg, $max, '$max_product');
EOF
    echo "SQL сохранён в import.sql"
fi
