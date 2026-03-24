# syshealth

System health monitoring utility written in Bash, featuring checks for:

- Disk usage
- Memory usage
- CPU usage
- Failed systemd services
- Failed login attempts
- Zombie processes
- Large files

---

## Sample Output

```
======================================================================================
 syshealth report
 2026-03-23 20:51:47
 cachy-666
======================================================================================

==== Disk Usage ====
[OK] / — 11G / 32G (33%)
[OK] /boot — 51M / 1022M (5%)

==== Memory Usage ====
[OK] Memory usage: 7764 MB / 15768 MB (49%)

==== CPU Usage ====
[OK] CPU usage: 4%

==== Failed Services ====
[WARN] 1 failed service:
  - fstrim.service

==== Failed Logins ====
[OK] No failed logins today

==== Zombie Processes ====
[OK] No zombie processes

==== Large Files (>+1G) ====
[WARN] Large files found in /home/user:
  - 6.7G /home/user/Music/album.zip
  - 31G /home/user/VMs/kali.qcow2
```

---

## Structure

```
syshealth/
├── syshealth.sh       # main script — thresholds, helpers, logging
├── logs/              # generated reports (gitignored)
└── checks/
    ├── disk.sh        # disk usage per partition
    ├── memory.sh      # RAM usage
    ├── cpu.sh         # CPU usage via /proc/stat
    ├── services.sh    # failed systemd services
    ├── logins.sh      # failed SSH login attempts
    ├── zombies.sh     # zombie processes
    └── large_files.sh # large file detection
```

---

## Requirements

- Bash 4.0+
- `systemd` — required for services and login checks (`systemctl`, `journalctl`)
- `awk`, `find`, `ps`, `df`, `free` — standard on all Linux systems

---

## Installation

```bash
git clone https://github.com/szymnli/syshealth.git
cd syshealth
chmod +x syshealth.sh
```

---

## Usage

```bash
./syshealth.sh
```

> Some checks may require root privileges for full output. Run with `sudo ./syshealth.sh` if needed.

---

## Logs

Each run generates a timestamped plain text log file saved to the `logs/` directory:

```
syshealth/
└── logs/
    ├── syshealth_2026-03-23_20-54-15.txt
    └── syshealth_2026-03-23_20-56-24.txt
```

---

## Customization

All thresholds and settings are defined at the top of `syshealth.sh`:

| Variable | Default | Description |
|---|---|---|
| `DISK_WARN` | `70` | Disk usage % to trigger warning |
| `DISK_CRITICAL` | `90` | Disk usage % to trigger critical alert |
| `MEMORY_WARN` | `80` | Memory usage % to trigger warning |
| `MEMORY_CRITICAL` | `95` | Memory usage % to trigger critical alert |
| `CPU_WARN` | `70` | CPU usage % to trigger warning |
| `CPU_CRITICAL` | `90` | CPU usage % to trigger critical alert |
| `LOGIN_WARN` | `10` | Failed login attempts to trigger warning |
| `ZOMBIE_WARN` | `1` | Zombie processes to trigger warning |
| `ZOMBIE_CRITICAL` | `5` | Zombie processes to trigger critical alert |
| `LARGE_FILE_SIZE` | `+1G` | Minimum file size to flag |
| `DIRS_TO_CHECK` | `$HOME /var/log /tmp` | Directories to scan for large files |
