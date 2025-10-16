#!/bin/bash
set -e

echo "🔍 Validating Open5GS YAML configuration files..."

if ! command -v python3 >/dev/null; then
  echo "❌ Python3 is required but not found."
  exit 1
fi

for file in $(find ./configs -type f -name "*.yaml" -o -name "*.yml"); do
  echo "Checking $file ..."
  python3 tests/validate_configs.py "$file" || {
    echo "❌ Validation failed for: $file"
    exit 1
  }
done

echo "✅ All configuration files passed validation!"

