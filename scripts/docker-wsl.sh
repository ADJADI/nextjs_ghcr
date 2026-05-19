#!/usr/bin/env bash
set -euo pipefail

# Run Docker Compose from WSL (project on /mnt/c/...).
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

export APP_VERSION="${APP_VERSION:-development}"
docker compose up --build "$@"
