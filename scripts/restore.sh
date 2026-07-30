#!/usr/bin/env bash
#
# ARTIZEN — restore from a backup produced by scripts/backup.sh (self-hosted /
# compose target). It is the tested counterpart of the backup, so a restore is
# never improvised on the day it matters.
#
# On Scalingo (T3 production), the database is restored from the managed Postgres
# addon's own backups (dashboard/CLI) and file storage from the S3 bucket's
# versioning — this script targets the local/compose stack. See docs/DEPLOYMENT-T3.md.
#
# Usage:  ./scripts/restore.sh <db_dump> [storage_tgz]
# Env:    DB_USER, DB_NAME, STORAGE_VOLUME
set -euo pipefail

DB_DUMP="${1:?usage: restore.sh <db_dump> [storage_tgz]}"
STORAGE_TGZ="${2:-}"
DB_USER="${DB_USER:-artizen}"
DB_NAME="${DB_NAME:-artizen}"
STORAGE_VOLUME="${STORAGE_VOLUME:-artizen-app_artizen_storage_data}"

export MSYS_NO_PATHCONV=1 # Git Bash: keep container-side paths intact

[ -f "$DB_DUMP" ] || { echo "No such dump: $DB_DUMP"; exit 1; }

echo "==> Stopping app containers (keep db up)..."
docker compose stop backend worker 2>/dev/null || docker compose stop backend

echo "==> Restoring database from $DB_DUMP (drop + recreate objects)..."
# --clean --if-exists replaces existing objects; --no-owner ignores the dump's
# role ownership (the restore role may differ). Custom-format dump (-Fc) on stdin.
docker compose exec -T db pg_restore -U "$DB_USER" -d "$DB_NAME" \
  --clean --if-exists --no-owner <"$DB_DUMP"

if [ -n "$STORAGE_TGZ" ]; then
  [ -f "$STORAGE_TGZ" ] || { echo "No such archive: $STORAGE_TGZ"; exit 1; }
  echo "==> Restoring storage volume from $STORAGE_TGZ..."
  archive_dir="$(cd "$(dirname "$STORAGE_TGZ")" && pwd)"
  docker run --rm \
    -v "$STORAGE_VOLUME:/data" \
    -v "$archive_dir:/backup:ro" \
    alpine sh -c "rm -rf /data/* && tar xzf /backup/$(basename "$STORAGE_TGZ") -C /data"
fi

echo "==> Restarting backend..."
docker compose start backend >/dev/null

echo "==> Restore complete. Verify:  curl -fsS http://localhost:8000/health"
