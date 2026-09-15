# Bash Scripting

Automating command-line tasks with plain text scripts run top to bottom by the shell.

## ⚡ Cheat Sheet

| Syntax | Purpose |
|---|---|
| `#!/bin/bash` | Shebang — which interpreter to use |
| `$VAR`, `"$VAR"` | Variable expansion (quote to be safe) |
| `if [ cond ]; then ... fi` | Conditional |
| `for x in list; do ... done` | Loop |
| `while [ cond ]; do ... done` | While loop |
| `function_name() { ... }` | Function definition |
| `set -euo pipefail` | Strict mode (fail fast) |
| `$?` | Exit code of last command |

## 📖 Details & Examples

### Basic structure

```bash
#!/bin/bash
echo "Starting backup..."

SOURCE_DIR="/home/dishant/data"
DEST_DIR="/backup"

if [ -d "$SOURCE_DIR" ]; then
    cp -r "$SOURCE_DIR" "$DEST_DIR"
    echo "Backup complete."
else
    echo "Source directory not found!" >&2
    exit 1
fi
```

```bash
chmod +x backup.sh
./backup.sh
```

### Variables & quoting

```bash
NAME="Dishant"
echo "Hello, $NAME"     # Hello, Dishant   (double quotes expand variables)
echo 'Hello, $NAME'     # Hello, $NAME     (single quotes = literal)
```

### Conditionals

```bash
if [ "$1" == "start" ]; then
    echo "Starting..."
elif [ "$1" == "stop" ]; then
    echo "Stopping..."
else
    echo "Usage: $0 {start|stop}"
fi
```

Common test operators:
| Test | Meaning |
|---|---|
| `-d` | is a directory |
| `-f` | is a file |
| `-z` | string is empty |
| `-eq`, `-ne`, `-lt`, `-gt` | numeric comparisons |
| `==`, `!=` | string comparisons |

### Loops

```bash
# Loop over files
for f in /var/log/*.log; do
    echo "Processing $f"
done

# Fixed range
for i in {1..5}; do
    echo "Attempt $i"
done

# While loop
count=0
while [ $count -lt 3 ]; do
    echo "Count is $count"
    ((count++))
done
```

### Functions

```bash
greet() {
    local name=$1
    echo "Hello, $name!"
}

greet "World"
```

### Error handling / strict mode

```bash
set -e          # exit immediately if a command fails
set -u          # error on undefined variables
set -o pipefail # catch failures inside piped commands

command_that_might_fail || echo "It failed, but we continue"
```

## 🛠️ Example: Disk space alert script

```bash
#!/bin/bash
THRESHOLD=80
USAGE=$(df / | tail -1 | awk '{print $5}' | tr -d '%')

if [ "$USAGE" -ge "$THRESHOLD" ]; then
    echo "WARNING: Root disk usage is at ${USAGE}%"
fi
```

## 🔗 See also
- [Grep-Sed-Awk](../Grep-Sed-Awk/grep-sed-awk.md) — text processing used heavily inside scripts
- [Cron](../Cron/cron.md) — scheduling these scripts to run automatically
