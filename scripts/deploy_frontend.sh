#!/usr/bin/env bash
#
# ARTIZEN — publish the static Flutter Web bundle to S3-compatible object storage
# + CDN (T3 frontend). Provider-agnostic: works with any EU S3 endpoint (Scaleway,
# OVH…) via the aws CLI. Build first with scripts/build_frontend.sh.
#
# Cache strategy: Flutter fingerprints its assets (main.dart.js etc.), so those are
# immutable and cached hard; index.html / the service worker / version.json must
# NOT be cached, so a new deploy is picked up immediately.
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

NEVER_CACHE=(index.html flutter_service_worker.js version.json)

echo "==> Uploading immutable, fingerprinted assets (cached 1 year)"
aws s3 sync "$DIST" "s3://$FRONTEND_S3_BUCKET" \
  --endpoint-url "$FRONTEND_S3_ENDPOINT" \
  --delete \
  --cache-control "public, max-age=31536000, immutable" \
  --exclude "${NEVER_CACHE[0]}" --exclude "${NEVER_CACHE[1]}" --exclude "${NEVER_CACHE[2]}"

echo "==> Uploading entrypoints (never cached)"
aws s3 sync "$DIST" "s3://$FRONTEND_S3_BUCKET" \
  --endpoint-url "$FRONTEND_S3_ENDPOINT" \
  --cache-control "no-cache, no-store, must-revalidate" \
  --exclude "*" \
  --include "${NEVER_CACHE[0]}" --include "${NEVER_CACHE[1]}" --include "${NEVER_CACHE[2]}"

echo "==> Published to s3://$FRONTEND_S3_BUCKET (remember to purge the CDN cache if it caches HTML)."
