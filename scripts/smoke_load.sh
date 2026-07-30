#!/usr/bin/env bash
#
# ARTIZEN — minimal load smoke.
#
# Fires N requests at /health concurrently and reports the success rate + wall
# time. This is a *smoke*, not a real load test: it uses only the unauthenticated
# health endpoint, no tool, no auth'd flows. A full load test (authenticated
# journeys with k6/locust) is post-launch. Purpose: catch an obvious fall-over
# for the "Performance (à confirmer)" line before go-live.
#
# Usage:  N=200 CONC=20 HEALTH_URL=http://localhost:8000/health ./scripts/smoke_load.sh
set -uo pipefail

URL="${HEALTH_URL:-http://localhost:8000/health}"
N="${N:-200}"
CONC="${CONC:-20}"

echo "Smoke: $N requests to $URL ($CONC concurrent)"
start=$(date +%s)

results="$(seq "$N" | xargs -P "$CONC" -I{} sh -c \
  'curl -s -o /dev/null -w "%{http_code}\n" --max-time 10 "$1"' _ "$URL")"

ok=$(printf '%s\n' "$results" | grep -c '^200$' || true)
end=$(date +%s)

echo "OK: $ok/$N in $((end - start))s"
if [ "$ok" -ne "$N" ]; then
  echo "WARN: $((N - ok)) non-200 responses"
  exit 1
fi
