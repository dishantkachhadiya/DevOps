# DNS Debugging

Tools and workflow for diagnosing "site not loading" / name resolution issues.

## ⚡ Cheat Sheet

| Command | Purpose |
|---|---|
| `dig example.com` | Query A record |
| `dig +short example.com` | Just the answer |
| `dig @8.8.8.8 example.com` | Query a specific DNS server |
| `dig +trace example.com` | Trace full resolution path |
| `nslookup example.com` | Simpler alternative to dig |
| `resolvectl status` | Check systemd-resolved config |
| `cat /etc/resolv.conf` | See configured resolver |

## 📖 Details & Examples

### Basic queries

```bash
dig example.com                 # full A record query + response details
dig +short example.com          # just the resolved IP
dig example.com MX              # mail server records
dig example.com TXT             # TXT records (SPF, verification, etc.)
dig example.com NS              # nameservers for the domain
```

### Query a specific DNS server

```bash
dig @8.8.8.8 example.com        # bypass local resolver, ask Google directly
dig @1.1.1.1 example.com        # ask Cloudflare directly
```

### Reverse lookup

```bash
dig -x 8.8.8.8
```

### Trace full resolution path (root → TLD → authoritative)

```bash
dig +trace example.com
```

### Check local resolver config

```bash
cat /etc/resolv.conf
```

### Test raw connectivity to a DNS server

```bash
nc -vz 8.8.8.8 53
```

## 🛠️ Example: Diagnosing "site not loading"

```bash
# 1. Does DNS resolve at all?
dig +short example.com

# 2. If it resolves, can you reach the IP directly?
curl -v https://<resolved-ip> -H "Host: example.com"

# 3. Is it a local resolver problem? Compare against public DNS
dig @1.1.1.1 example.com
dig @8.8.8.8 example.com
```

If it resolves fine against `8.8.8.8` but not your default resolver → the problem is your **local DNS config**, not the domain.

## 📖 systemd-resolved (common on Ubuntu)

```bash
resolvectl status              # current DNS resolution status
sudo resolvectl flush-caches   # flush local DNS cache
resolvectl query example.com   # query using resolvectl
```

## 🔗 See also
- [Journald](../Journald/journald.md) — check `journalctl -u systemd-resolved` for resolver errors
