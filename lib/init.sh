#!/bin/bash

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LIB_DIR="$ROOT_DIR/lib"
ACORE_DIR="$ROOT_DIR/azerothcore-wotlk"
MODULES_DIR="$ACORE_DIR/modules"
CUSTOM_SQL_DIR="$ROOT_DIR/env/data/sql/custom"

LINE_LONG="-----------------------------------------------------"
LINE_SHORT="----"

if [ -f "$ROOT_DIR/.env" ]; then
  # Load vars from .env file
  source "$ROOT_DIR/.env"
fi

source "$LIB_DIR/utils.sh"