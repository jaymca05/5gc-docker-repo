#!/usr/bin/env python3
import sys, yaml

required_top_keys = ["logger", "parameter", "db_uri", "nrf"]

try:
    with open(sys.argv[1], "r") as f:
        data = yaml.safe_load(f)
except Exception as e:
    print(f"YAML parsing error: {e}")
    sys.exit(1)

# basic schema check (non-strict)
if not isinstance(data, dict):
    print("Invalid config: Root element must be a dictionary")
    sys.exit(1)

missing = [k for k in required_top_keys if k not in data]
if missing:
    print(f"Missing required keys: {', '.join(missing)}")

sys.exit(0 if not missing else 1)

