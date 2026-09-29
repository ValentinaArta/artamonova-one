#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR=/root/artamonova-website
WEB_ROOT=/var/www/artamonova.one

if [[ $(id -u) -ne 0 ]]; then
  echo "Run this script as root." >&2
  exit 1
fi

git -C "$PROJECT_DIR" pull --ff-only origin main
install -d -m 755 "$WEB_ROOT/assets"
install -m 644 "$PROJECT_DIR/index.html" "$WEB_ROOT/index.html"
install -m 644 "$PROJECT_DIR/assets/valentina-artamonova.jpg" "$WEB_ROOT/assets/valentina-artamonova.jpg"
install -d -m 755 "$WEB_ROOT/speed-queen-hub"
install -m 644 "$PROJECT_DIR/speed-queen-hub/index.html" "$WEB_ROOT/speed-queen-hub/index.html"
echo "Site updated: https://artamonova.one"
