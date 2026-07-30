#!/usr/bin/env bash
#
# ARTIZEN — build the Flutter Web bundle for production (T3: static frontend).
#
# The API base URL is baked in at BUILD time (Flutter's String.fromEnvironment),
# so it must be passed here — the deployed bundle then talks to that API forever
# (a domain change means a rebuild). Output: frontend/build/web (the static files
# to publish with scripts/deploy_frontend.sh).
#
# Usage:  API_BASE_URL=https://api.artizen.fr/api ./scripts/build_frontend.sh
set -euo pipefail

API_BASE_URL="${API_BASE_URL:-https://api.artizen.fr/api}"
cd "$(dirname "$0")/../frontend"

echo "==> flutter pub get"
flutter pub get

echo "==> Building release web bundle (API_BASE_URL=$API_BASE_URL)"
flutter build web --release --dart-define=API_BASE_URL="$API_BASE_URL"

echo "==> Done: frontend/build/web"
echo "    Publish it with: scripts/deploy_frontend.sh"
