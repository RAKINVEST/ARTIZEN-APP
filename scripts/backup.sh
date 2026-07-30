#!/usr/bin/env bash
#
# ARTIZEN — consistent backup (database + storage volume).
#
# Versioned, runnable form of the tested manual procedure documented in
# docs/BACKUP_RESTORE.md. Stops the backend for a coherent point-in-time (the
# DB references file paths in the storage volume), dumps both, restarts.
#
# Produces, in $BACKUP_DIR (default ./backups):
#   db_<stamp>.dump       PostgreSQL custom-format dump (pg_restore-able)
#   storage_<stamp>.tgz   the storage volume (logos, templates, documents)
#
# Everything here is DEPLOYMENT-CONFIG-FREE. What remains for production is
# *activation*, not code: schedule (cron/systemd timer), off-site encrypted
# copy, and RETENTION_DAYS (kept at 0 until the RGPD retention policy is set).
#
# Usage:  ./scripts/backup.sh
# Env:    BACKUP_DIR, STORAGE_VOLUME, DB_USER, DB_NAME, RETENTION_DAYS
set -euo pipefail

BACKUP_DIR="${BACKUP_DIR:-./backups}"
STORAGE_VOLUME="${STORAGE_VOLUME:-artizen-app_artizen_storage_data}"
DB_USER="${DB_USER:-artizen}"
DB_NAME="${DB_NAME:-artizen}"
RETENTION_DAYS="${RETENTION_DAYS:-0}" # 0 = keep everything (retention policy TBD)

export MSYS_NO_PATHCONV=1 # Git Bash: keep container-side paths (/data, /backup) intact

mkdir -p "$BACKUP_DIR"
BACKUP_DIR="$(cd "$BACKUP_DIR" && pwd)"
STAMP="$(date +%F_%H%M%S)"

echo "==> Stopping backend for a consistent point-in-time..."
docker compose stop backend

restart_backend() {
  echo "==> Restarting backend..."
  docker compose start backend >/dev/null
}
trap restart_backend EXIT

echo "==> Dumping database -> $BACKUP_DIR/db_$STAMP.dump"
docker compose exec -T db pg_dump -U "$DB_USER" -d "$DB_NAME" -Fc >"$BACKUP_DIR/db_$STAMP.dump"

echo "==> Archiving storage volume -> $BACKUP_DIR/storage_$STAMP.tgz"
docker run --rm \
  -v "$STORAGE_VOLUME:/data:ro" \
  -v "$BACKUP_DIR:/backup" \
  alpine tar czf "/backup/storage_$STAMP.tgz" -C /data .

# Retention is disabled by default; enable it only once the RGPD retention
# policy fixes a duration (RETENTION_DAYS).
if [ "$RETENTION_DAYS" -gt 0 ]; then
  echo "==> Pruning backups older than $RETENTION_DAYS days"
  find "$BACKUP_DIR" -name 'db_*.dump' -mtime "+$RETENTION_DAYS" -delete
  find "$BACKUP_DIR" -name 'storage_*.tgz' -mtime "+$RETENTION_DAYS" -delete
fi

echo "==> Backup complete:"
echo "    $BACKUP_DIR/db_$STAMP.dump"
echo "    $BACKUP_DIR/storage_$STAMP.tgz"
echo
echo "Production activation (not code — deployment config):"
echo "  - schedule this script (cron / systemd timer);"
echo "  - copy \$BACKUP_DIR off-site, encrypted;"
echo "  - set RETENTION_DAYS per the RGPD retention policy;"
echo "  - test a restore regularly (see docs/BACKUP_RESTORE.md)."
