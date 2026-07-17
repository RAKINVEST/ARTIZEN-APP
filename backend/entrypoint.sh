#!/usr/bin/env bash
set -e

# --- Phase 1: running as root, only to stop running as root ---
#
# The application must not run as root, but the storage volume has to be
# writable by the user it does run as — and Docker only copies the image's
# ownership onto a named volume it creates *empty*. A volume that already
# exists (anyone who ran an earlier build, where the container was root)
# stays root-owned, and every upload then fails with EACCES.
#
# That failure is unusually nasty: the container reports *healthy*, because
# /health only does SELECT 1 and never touches storage. Nothing looks wrong
# until a real artisan uploads a logo.
#
# So: fix the ownership while we still can, then drop privileges and re-exec
# this same script as `artizen`. Everything below phase 1 runs unprivileged.
# setpriv comes with the base image (util-linux) — no extra package, and
# unlike `su` it execs directly, so uvicorn stays PID 1 and still receives
# SIGTERM on `docker compose stop`.
if [ "$(id -u)" = "0" ]; then
  storage_root="${STORAGE_LOCAL_ROOT:-/data/storage}"
  artizen_uid="$(id -u artizen)"
  mkdir -p "$storage_root"
  # Check the whole tree, not just the root. Checking only the root missed a
  # real case: on a volume Docker initialized empty, the root is created
  # owned by artizen, so the check passed — but the subdirectories that
  # `LocalStorageProvider.save` creates (logos/, templates/,
  # document_analysis/) were made by an earlier root-running container and
  # stayed root-owned. Uploads then failed with EACCES on the subdir while
  # the root looked fine. `find -not -user` stops at the first offender, so
  # this stays cheap when everything is already correct and only pays for a
  # recursive chown when something actually needs fixing.
  if [ -n "$(find "$storage_root" -not -user "$artizen_uid" -print -quit 2>/dev/null)" ]; then
    echo "Storage under $storage_root has files not owned by artizen — fixing ownership..."
    chown -R artizen:artizen "$storage_root"
  fi
  # setpriv changes the uid/gid and nothing else — HOME keeps pointing at
  # /root, which the new user cannot read. That surfaces a long way from
  # here: asyncpg looks for ~/.postgresql/postgresql.key on every connect
  # and dies with EACCES on /root/.postgresql, so the container
  # restart-loops with a TLS-looking error that has nothing to do with TLS.
  export HOME=/home/artizen

  # Re-exec through `bash` explicitly, for the same reason the Dockerfile's
  # ENTRYPOINT does: the compose bind mount shadows /app, and with it the
  # exec bit set at build time. setpriv execs its argument directly, so
  # handing it the script path alone fails with "No such file or directory".
  exec setpriv --reuid=artizen --regid=artizen --init-groups bash "$0" "$@"
fi

# --- Phase 2: unprivileged from here on ---

echo "Waiting for database at ${POSTGRES_HOST:-db}:${POSTGRES_PORT:-5432}..."
until python -c "
import os, socket, sys
host = os.environ.get('POSTGRES_HOST', 'db')
port = int(os.environ.get('POSTGRES_PORT', 5432))
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.settimeout(1)
try:
    s.connect((host, port))
except OSError:
    sys.exit(1)
finally:
    s.close()
"; do
  sleep 1
done

echo "Database is available. Running migrations..."
alembic upgrade head

echo "Starting application..."
exec "$@"
