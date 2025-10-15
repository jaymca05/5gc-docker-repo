#!/usr/bin/env bash
set -e

# List of services to check
services=("nrf" "amf" "smf" "upf" "udm" "udr" "ausf" "pcf")

# Function to check health status of a container
check_health() {
  local container=$1
  local status
  status=$(docker inspect --format '{{.State.Health.Status}}' "$container" 2>/dev/null || echo "no health")
  echo "$container → $status"
}

# Function to display health check logs for a container
show_health_logs() {
  local container=$1
  docker inspect --format '{{json .State.Health}}' "$container" | jq
}

# Check health status of each service
echo "Checking health status of services..."
for service in "${services[@]}"; do
  check_health "$service"
done

# Display detailed logs for any unhealthy containers
echo -e "\nDetailed health check logs for unhealthy containers:"
for service in "${services[@]}"; do
  status=$(docker inspect --format '{{.State.Health.Status}}' "$service" 2>/dev/null || echo "no health")
  if [[ "$status" != "healthy" && "$status" != "no health" ]]; then
    echo -e "\n$service:"
    show_health_logs "$service"
  fi
done

