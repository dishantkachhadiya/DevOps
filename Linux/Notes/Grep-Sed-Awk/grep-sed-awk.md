# grep / sed / awk

The three core text-processing tools that cover almost all everyday log/data manipulation on Linux.

## ⚡ Cheat Sheet

| Command | Purpose |
|---|---|
| `grep "pattern" file` | Search for text |
| `grep -r "pattern" dir/` | Recursive search |
| `grep -v "pattern"` | Invert match |
| `sed 's/old/new/g' file` | Replace text |
| `sed -i 's/old/new/g' file` | Replace in place |
| `sed -n '10,20p' file` | Print line range |
| `awk '{print $1}' file` | Print a column |
| `awk -F, '{print $2}' file` | Custom delimiter |

## 📖 grep — search text

```bash
grep "error" /var/log/syslog          # basic search
grep -i "error" /var/log/syslog       # case-insensitive
grep -r "TODO" ./src                  # recursive through a directory
grep -n "error" file.log              # show line numbers
grep -v "debug" file.log              # invert match (lines NOT matching)
grep -c "error" file.log              # count matches
grep -E "error|warning" file.log      # extended regex (OR, etc.)
grep -A2 -B2 "Exception" app.log      # 2 lines of context around match
```

## 📖 sed — stream editor

```bash
sed 's/foo/bar/' file.txt             # replace first occurrence per line
sed 's/foo/bar/g' file.txt            # replace ALL occurrences per line
sed -i.bak 's/foo/bar/g' file.txt     # edit in place, keep .bak backup
sed '/^#/d' config.txt                # delete comment lines
sed -n '10,20p' file.txt              # print only lines 10-20
sed '/ERROR/s/foo/bar/' file.txt      # replace only on matching lines
```

## 📖 awk — pattern scanning & columns

```bash
awk '{print $1, $3}' file.txt              # print specific columns
awk -F, '{print $2}' data.csv              # custom delimiter (CSV)
awk '{sum += $2} END {print sum}' data.txt # sum a column
awk '$3 > 100 {print $0}' data.txt         # filter rows by condition
awk '{print NR, $0}' file.txt              # line number + line
awk '/error/ {print $1, $NF}' log.txt      # first + last field on matching lines
```

## 🛠️ Example: Chained pipeline

Top 5 IP addresses hitting a server from an access log:

```bash
awk '{print $1}' access.log | sort | uniq -c | sort -rn | head -5
```

## 🛠️ Example: Extract and sum

Sum the 2nd column of a CSV where the 3rd column is "success":

```bash
awk -F, '$3 == "success" {sum += $2} END {print sum}' data.csv
```

## 🔗 See also
- [Grep-Sed-Awk](../Grep-Sed-Awk/grep-sed-awk.md) — text processing used heavily inside scripts
- [Cron](../Cron/cron.md) — scheduling these scripts to run automatically
