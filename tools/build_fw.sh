#!/bin/bash
# Build Meshtastic with ViVSoft custom modules
# Usage: ./build_fw.sh heltec-v3|tracker-t1000-e
# Outputs firmware to artifacts/

set -e

ENV="${1:-tracker-t1000-e}"
FW_DIR="$HOME/src/firmware"
ARTIFACTS="$HOME/firmware-artifacts"

cd "$FW_DIR"

echo "=== Building $ENV ==="
~/.local/bin/pio run -e "$ENV"

mkdir -p "$ARTIFACTS"

if [ "$ENV" = "tracker-t1000-e" ]; then
    cp .pio/build/tracker-t1000-e/firmware-tracker-t1000-e-*.uf2 "$ARTIFACTS/" 2>/dev/null || true
    cp .pio/build/tracker-t1000-e/firmware-tracker-t1000-e-*.hex "$ARTIFACTS/" 2>/dev/null || true
    cp .pio/build/tracker-t1000-e/firmware-tracker-t1000-e-*.zip "$ARTIFACTS/" 2>/dev/null || true
elif [ "$ENV" = "heltec-v3" ]; then
    cp .pio/build/heltec-v3/firmware-*.factory.bin "$ARTIFACTS/" 2>/dev/null || true
    cp .pio/build/heltec-v3/firmware-*.bin "$ARTIFACTS/" 2>/dev/null || true
fi

echo "=== Built artifacts in $ARTIFACTS ==="
ls -la "$ARTIFACTS"