#!/usr/bin/env bash

# List all containers in your stack
for cname in nrf amf smf upf udm udr ausf pcf; do
  status=$(docker inspect --format='{{.State.Health.Status}}' $cname 2>/dev/null || echo "no health")
  echo "$cname → $status"
done

