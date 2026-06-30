# EMERGENCY: wrong clock on boot, time won't sync

## 1) Confirm the situation

```bash
timedatectl status
chronyc tracking
chronyc sources -v
```

## 2) Set the clock to roughly "now" so DoT/NTS certs validate.

(a) Simplest — type an approximate current LOCAL wall-clock time:

```bash
sudo date -s 'YYYY-MM-DD HH:MM:SS'
```

(b) Or pull rough time from a plain-HTTP Date header (no DNS, no TLS). 1.1.1.1 works; any reachable HTTP server IP (incl. your gateway) does.

```bash
sudo date -s "$(curl -sI http://1.1.1.1 | tr -d '\r' | sed -n 's/^[Dd]ate: //p')"
```

## 3) Force chrony to re-resolve, re-key (NTS-KE), and step to true time

```bash
sudo systemctl restart chronyd
sudo chronyc burst 4/4
sleep 8
sudo chronyc makestep
```

## 4) Verify

```bash
chronyc tracking            # 'Leap status : Normal', offset ~0
chronyc -N authdata         # Cook > 0 on each NTS source
timedatectl status          # 'System clock synchronized: yes'
```

## 5) Write the correct time back into the RTC

```bash
sudo hwclock --systohc
```

Persists only if the CMOS battery is healthy. A dead battery loses the RTC at power-off; '-s' re-floors each boot, but replacing the battery is the only permanent fix.
