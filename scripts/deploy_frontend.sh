#!/usr/bin/env bash
#
# ARTIZEN — publish the static Flutter Web bundle to S3-compatible object storage
# + CDN (T3 frontend). Provider-agnostic: works with any EU S3 endpoint (Scaleway,
# OVH…) via the aws CLI. Build first with scripts/build_frontend.sh.
#
# Cache strategy: Flutter does NOT content-hash its entry files — index.html,
# main.dart.js, flutter.js, flutter_bootstrap.js, the service worker, version.json
# and manifest.json keep the SAME name every build — so they are served no-cache
# (otherwise returning visitors run stale app code after a redeploy). Only the
# versioned/static content (canvaskit/, assets/, icons/, favicon) is cached hard.
#
# Required env: FRONTEND_S3_ENDPOINT, FRONTEND_S3_BUCKET (aws CLI credentials via
# the usual AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY / AWS_REGION).
#
# Usage:
#   FRONTEND_S3_ENDPOINT=https://s3.fr-par.scw.cloud FRONTEND_S3_BUCKET=artizen-web \
#     ./scripts/deploy_frontend.sh
set -euo pipefail

: "${FRONTEND_S3_ENDPOINT:?set FRONTEND_S3_ENDPOINT (e.g. https://s3.fr-par.scw.cloud)}"
: "${FRONTEND_S3_BUCKET:?set FRONTEND_S3_BUCKET}"

DIST="$(cd "$(dirname "$0")/../frontend" && pwd)/build/web"
[ -d "$DIST" ] || { echo "No build found at $DIST — run scripts/build_frontend.sh first."; exit 1; }

# Files that change on every build but keep the same name → never long-cached.
NEVER_CACHE=(index.html main.dart.js flutter.js flutter_bootstrap.js flutter_service_worker.js version.json manifest.json)

excludes=(); includes=()
for f in "${NEVER_CACHE[@]}"; do excludes+=(--exclude "$f"); includes+=(--include "$f"); done

echo "==> Uploading long-lived content (canvaskit/, assets/, icons/… cached 1 year)"
aws s3 sync "$DIST" "s3://$FRONTEND_S3_BUCKET" \
  --endpoint-url "$FRONTEND_S3_ENDPOINT" \
  --delete \
  --cache-control "public, max-age=31536000, immutable" \
  "${excludes[@]}"

echo "==> Uploading entry files (never cached)"
aws s3 sync "$DIST" "s3://$FRONTEND_S3_BUCKET" \
  --endpoint-url "$FRONTEND_S3_ENDPOINT" \
  --cache-control "no-cache, no-store, must-revalidate" \
  --exclude "*" \
  "${includes[@]}"

echo "==> Published to s3://$FRONTEND_S3_BUCKET (remember to purge the CDN cache if it caches HTML)."
