#!/usr/bin/env bash
#
# ARTIZEN — production health probe.
#
# Exits 0 when the API is healthy, non-zero otherwise. Point a cron job, an
# uptime monitor, or a container/orchestrator liveness probe at it, and route a
# non-zero exit to your alert channel (email / Slack / PagerDuty). The monitor
# and the alert channel are DEPLOYMENT config, not code — this script is the
# decision-free part of "Alertes de production".
#
# Usage:  HEALTH_URL=https://api.example.com/health ./scripts/healthcheck.sh
set -uo pipefail

URL="${HEALTH_URL:-http://localhost:8000/health}"

body="$(curl -fsS --max-time 5 "$URL" 2>/dev/null)" || {
  echo "CRITICAL: $URL unreachable"
  exit 2
}

# /health answers 200 with {"status":"ok",...}, and reports "degraded" (DB/Redis
# down) instead of "ok" — so a healthy service is exactly status == ok.
case "$body" in
  *'"status":"ok"'*)
    echo "OK: $body"
    exit 0
    ;;
  *)
    echo "CRITICAL: not healthy — $body"
    exit 1
    ;;
esac
