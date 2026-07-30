#!/usr/bin/env bash
#
# ARTIZEN — RGPD retention purge (cron-activatable).
#
# Runs the configuration-driven retention engine (app/retention). A strict
# no-op unless a retention duration is set (RETENTION_*_DAYS) — nothing is
# purged by default. The POLICY (durations, scope) is the juriste's; ACTIVATION
# (scheduling this via cron/systemd timer) is a deployment concern.
#
# Usage:  ./scripts/retention_purge.sh
set -euo pipefail
docker compose exec -T backend python -m app.retention
