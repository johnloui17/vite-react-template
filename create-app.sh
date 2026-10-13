#!/usr/bin/env bash
# Scaffold a new app from this boilerplate.
# Usage: create-app.sh <app-name> [parent-dir]   (parent-dir defaults to the current directory)
set -euo pipefail

TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NAME="${1:-}"
PARENT="${2:-$PWD}"

if [[ -z "$NAME" ]]; then
  echo "Usage: $(basename "$0") <app-name> [parent-dir]" >&2
  exit 1
fi

TARGET="$PARENT/$NAME"
if [[ -e "$TARGET" ]]; then
  echo "Error: $TARGET already exists" >&2
  exit 1
fi

rsync -a \
  --exclude node_modules \
  --exclude dist \
  --exclude .git \
  --exclude create-app.sh \
  --exclude '.env' \
  --exclude '*.local' \
  "$TEMPLATE_DIR/" "$TARGET/"

cd "$TARGET"
sed -i '' "s/\"name\": \"[^\"]*\"/\"name\": \"$NAME\"/" package.json package-lock.json 2>/dev/null || true
sed -i '' "s|<title>.*</title>|<title>$NAME</title>|" index.html

git init -q
npm install
git add -A && git commit -qm "Initial commit from vite boilerplate"

echo
echo "Created $TARGET"
echo "  cd $TARGET && npm run dev"
