# Disk & Memory Analysis

Tools for diagnosing storage and RAM usage, and spotting what's consuming resources.

## ⚡ Cheat Sheet

| Command | Purpose |
|---|---|
| `df -h` | Disk space per filesystem |
| `du -sh <dir>` | Size of a directory |
| `free -h` | RAM + swap overview |
| `top` / `htop` | Live process resource usage |
| `ps aux --sort=-%mem` | Processes sorted by memory |
| `vmstat 2 5` | CPU/mem/IO snapshot over time |
| `iostat -xz 2` | Disk I/O per device |
| `iotop` | Live per-process disk I/O |

## 📖 Details & Examples

### Disk usage

```bash
df -h                                    # space per filesystem
du -sh /var/log                          # total size of one directory
du -h --max-depth=1 | sort -rh | head -10  # top 10 largest subdirs here
find / -type f -size +500M 2>/dev/null   # find files over 500MB
df -i                                    # inode usage (can run out even with free space)
```

### Memory usage

```bash
free -h                                  # human-readable RAM/swap summary
cat /proc/meminfo                        # detailed raw memory stats
ps aux --sort=-%mem | head -10           # top memory-consuming processes
top                                      # live view
htop                                     # nicer live view (if installed)
```

### I/O & performance

```bash
vmstat 2 5        # CPU/mem/IO stats, every 2s, 5 times
iostat -xz 2       # disk I/O per device, every 2s
iotop              # which process is hammering disk I/O
```

## 🛠️ Example: Find what's eating your disk

```bash
du -h --max-depth=1 /var | sort -rh | head -5
```
Lists the 5 largest top-level directories under `/var` — a common place logs and package caches balloon over time.

## 🛠️ Example: Find memory-hungry process

```bash
ps aux --sort=-%mem | head -5
```

## 🔗 See also
- [Bash-Scripting](../Bash-Scripting/bash-scripting.md) — automate disk alerts (see the disk space script example)
- [Cron](../Cron/cron.md) — schedule regular disk/memory checks
