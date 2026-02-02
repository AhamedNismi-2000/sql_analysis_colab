import csv
import re

sql_file = "contoso_100k.sql"

with open(sql_file, "r", encoding="utf-8") as f:
    lines = f.readlines()

table_name = None
columns = []
rows = []

for line in lines:
    line = line.strip()

    # Detect COPY statement
    copy_match = re.match(r"COPY (\S+) \((.+)\) FROM stdin;", line)
    if copy_match:
        table_name = copy_match.group(1).split('.')[-1]  # remove schema like public.currencyexchange
        columns = [col.strip() for col in copy_match.group(2).split(',')]
        rows = []
        continue

    # End of COPY data
    if line == r"\.":
        if table_name and rows:
            # Write to CSV
            with open(f"{table_name}.csv", "w", newline='', encoding="utf-8") as csvfile:
                writer = csv.writer(csvfile)
                writer.writerow(columns)  # real column names
                writer.writerows(rows)
            print(f"Exported {table_name}.csv with {len(rows)} rows")
        table_name = None
        columns = []
        rows = []
        continue

    # Collect row data
    if table_name:
        row = line.split('\t')  # data is tab-separated
        rows.append(row)
