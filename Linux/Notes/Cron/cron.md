# cron

Runs scheduled jobs at fixed times/intervals. Each user has their own crontab; there's also system-wide `/etc/crontab` and `/etc/cron.d/`.

## ⚡ Cheat Sheet

| Command | Purpose |
|---|---|
| `crontab -e` | Edit your crontab |
| `crontab -l` | List your cron jobs |
| `crontab -r` | Remove your crontab |
| `* * * * *` | min hour day month weekday |

## 📖 Crontab syntax

```
* * * * *  command-to-run
│ │ │ │ │
│ │ │ │ └── day of week (0-7, 0 and 7 = Sunday)
│ │ │ └──── month (1-12)
│ │ └────── day of month (1-31)
│ └──────── hour (0-23)
└────────── minute (0-59)
```

## 📖 Examples

```bash
# Every day at 2:30 AM
30 2 * * * /home/dishant/backup.sh

# Every 15 minutes
*/15 * * * * /usr/local/bin/healthcheck.sh

# Every Monday at 9 AM
0 9 * * 1 /home/dishant/weekly_report.sh

# 1st of every month at midnight
0 0 1 * * /home/dishant/monthly_cleanup.sh

# Every weekday (Mon-Fri) at 6 PM
0 18 * * 1-5 /home/dishant/eod_script.sh
```

## 📖 Logging cron output

cron jobs run silently by default — always redirect output if you want to debug later:

```bash
30 2 * * * /home/dishant/backup.sh >> /home/dishant/backup.log 2>&1
```

## 📖 Debugging cron

```bash
journalctl -u cron          # cron's own logs (systemd systems)
grep CRON /var/log/syslog   # older / non-systemd systems
```

> ⚠️ **Common gotcha:** cron runs with a minimal environment (no full `$PATH`, no shell profile).
> Always use **full paths** in your scripts and commands, or explicitly `source` your profile at the top of the script.

## 🔗 See also
- [bash-scripting.md](./bash-scripting.md) — scripts you'll typically schedule
- [journald.md](./journald.md) — `journalctl -u cron` for debugging
