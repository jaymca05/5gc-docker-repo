#!/usr/bin/env python3
import subprocess, sys

services = ["nrf", "amf", "smf", "udm", "ausf", "pcf"]
failed = False

for svc in services:
    try:
        logs = subprocess.check_output(["docker", "logs", f"open5gs-{svc}_1"], text=True)
        if "Open5GS daemon" not in logs:
            print(f"❌ {svc}: did not start properly (no 'Open5GS daemon' message)")
            failed = True
        if "ERROR" in logs or "Segmentation fault" in logs:
            print(f"⚠️  {svc}: errors detected in logs")
            failed = True
    except subprocess.CalledProcessError:
        print(f"⚠️  Could not get logs for {svc} — maybe not running")
        failed = True

if failed:
    sys.exit(1)

print("✅ All services appear healthy in logs.")

