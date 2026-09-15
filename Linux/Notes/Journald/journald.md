# journald

systemd's logging service. Collects logs from the kernel, services, and apps into a structured, indexed binary format — replaces plain-text `/var/log/syslog` style logging on most modern distros.

## ⚡ Cheat Sheet

| Command | Purpose |
|---|---|
| `journalctl` | Show all logs (oldest first) |
| `journalctl -f` | Follow logs live (`tail -f` style) |
| `journalctl -u <service>` | Logs for one service |
| `journalctl -b` | Logs since last boot |
| `journalctl -p err` | Only errors and above |
| `journalctl -k` | Kernel messages only |
| `journalctl --since "1 hour ago"` | Time-filtered logs |
| `journalctl --vacuum-size=200M` | Trim log size |

## 📖 Details & Examples

### Basic viewing

```bash
journalctl                 # all logs, oldest first
journalctl -f               # live tail
journalctl -r               # reverse order (newest first)
```

### Filter by service

```bash
journalctl -u ssh
journalctl -u nginx -f       # follow a specific service live
```

### Filter by boot

```bash
journalctl -b                # current boot
journalctl -b -1             # previous boot
journalctl --list-boots      # see all recorded boots
```

### Filter by time

```bash
journalctl --since "2026-09-14 09:00" --until "2026-09-14 10:00"
journalctl --since "1 hour ago"
journalctl --since today
```

### Filter by severity

```bash
journalctl -p err            # err and above (crit, alert, emerg)
journalctl -p warning
```

### Kernel logs (like `dmesg`)

```bash
journalctl -k
```

### Managing disk usage

```bash
journalctl --disk-usage              # how much space logs take
sudo journalctl --vacuum-size=200M   # shrink to 200MB
sudo journalctl --vacuum-time=2weeks # keep only last 2 weeks
```

## 🛠️ Example: Why did my service crash on boot?

```bash
journalctl -u myscript.service -b --no-pager
```
Shows every log line from `myscript.service` during the current boot only — no noise from other services or previous boots.

## 🔗 See also
- [Systemd](../Systemd/systemd.md) — services that journald logs 
