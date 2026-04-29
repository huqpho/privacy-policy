#!/bin/bash
set -e

APP_PORT="${APP_PORT:-2001}"
PORT="${PORT:-$APP_PORT}"
export APP_PORT PORT
APP_NAME="${APP_NAME:-$(basename "$(pwd)")}"
APP_ENTRY_DEFAULT="server.js"

cd "$(dirname "$0")"

APP_ENTRY=""
if [ -n "$APP_ENTRY_DEFAULT" ] && [ -f "$APP_ENTRY_DEFAULT" ]; then
  APP_ENTRY="$APP_ENTRY_DEFAULT"
elif [ -f "server.js" ]; then
  APP_ENTRY="server.js"
elif [ -f "index.js" ]; then
  APP_ENTRY="index.js"
fi

if command -v pm2 >/dev/null 2>&1; then
  if [ -n "$APP_ENTRY" ]; then
    PORT="$PORT" pm2 describe "$APP_NAME" >/dev/null 2>&1 \
      && PORT="$PORT" pm2 reload "$APP_NAME" --update-env \
      || PORT="$PORT" pm2 start "$APP_ENTRY" --name "$APP_NAME"
  elif [ -f "package.json" ]; then
    PORT="$PORT" pm2 describe "$APP_NAME" >/dev/null 2>&1 \
      && PORT="$PORT" pm2 reload "$APP_NAME" --update-env \
      || PORT="$PORT" pm2 start npm --name "$APP_NAME" -- run start
  else
    echo "[start.sh] no server.js/index.js/package.json start script found"
    exit 1
  fi
  pm2 save
else
  echo "[start.sh] pm2 not found, run node directly on port $PORT"
  if [ -n "$APP_ENTRY" ]; then
    PORT="$PORT" node "$APP_ENTRY"
  elif [ -f "package.json" ]; then
    PORT="$PORT" npm run start
  else
    echo "[start.sh] no runnable entry found"
    exit 1
  fi
fi
