#!/bin/sh
set -eu
STATUS_DIR=/var/run/demo-service
DATA_DIR=/opt/demo-data
mkdir -p "$STATUS_DIR" "$DATA_DIR"
[ -f "$DATA_DIR/sample.txt" ] || printf '%s\n' 'data simulasi Sistem Operasi' > "$DATA_DIR/sample.txt"
printf '%s\n' "$(date -u +%FT%TZ) demo-service started" >> "$STATUS_DIR/service.log"
trap 'rm -f "$STATUS_DIR/healthy"; exit 0' INT TERM
while :; do
  touch "$STATUS_DIR/healthy"
  printf '%s\n' "$(date -u +%FT%TZ) demo-service healthy" >> "$STATUS_DIR/service.log"
  sleep 5
done
