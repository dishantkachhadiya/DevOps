# systemd

Init system and service manager on most modern Linux distros. Manages "units" — services, sockets, mounts, timers — and controls boot order via targets.

## 🧠 Key Concepts

- **Unit** — a resource systemd manages (service, socket, timer, mount, etc.)
- **Unit file** — config file; user overrides in `/etc/systemd/system/`, package defaults in `/usr/lib/systemd/system/`
- **Target** — group of units, like old "runlevels" (`multi-user.target`, `graphical.target`)

## ⚡ Cheat Sheet

| Command | Purpose |
|---|---|
| `systemctl status <svc>` | Check service status |
| `systemctl start/stop/restart <svc>` | Control service |
| `systemctl reload <svc>` | Reload config without full restart |
| `systemctl enable --now <svc>` | Enable at boot + start now |
| `systemctl daemon-reload` | Reload unit files after editing |
| `systemctl list-units --type=service` | List active services |
| `systemd-analyze blame` | See what's slowing down boot |

## 📖 Details & Examples

### Basic service control

```bash
systemctl status nginx
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
systemctl reload nginx          # reload config without killing the process
```

### Enable/disable at boot

```bash
systemctl enable nginx          # start on boot
systemctl disable nginx         # don't start on boot
systemctl enable --now nginx    # enable + start immediately
```

### Inspecting units

```bash
systemctl list-units --type=service        # all active services
systemctl list-unit-files                  # all units + enabled state
systemctl status nginx -l                  # full status, no truncation
```

### After editing a unit file

```bash
sudo systemctl daemon-reload
sudo systemctl restart myservice
```

### Boot performance

```bash
systemd-analyze                 # total boot time
systemd-analyze blame           # which services took longest
systemd-analyze critical-chain  # dependency chain that delayed boot
```

## 🛠️ Example: Custom service file

`/etc/systemd/system/myscript.service`:

```ini
[Unit]
Description=My custom background script
After=network.target

[Service]
ExecStart=/usr/local/bin/myscript.sh
Restart=on-failure
User=dishant

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now myscript.service
```

## 🔗 See also
- [Journald](../Journald/journald.md) — `journalctl -u <service>` to debug a failing unit
