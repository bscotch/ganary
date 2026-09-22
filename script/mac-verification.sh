#!/usr/bin/env bash
#
# run_ganary_olympus.sh
#
# Downloads a Ganary.app release build from github.com/bscotch/ganary,
# runs it in Olympus headless mode, uploads the log and result JSON back
# to that release as assets, and validates the resulting test report.
#
# Usage:
#   ./run_ganary_olympus.sh [release-tag]
#
# If no release tag is given, the latest release is used.
#
# Requirements:
#   - gh (GitHub CLI), authenticated with access to bscotch/ganary
#   - jq
#   - unzip
#
# Exit codes:
#   0 - Olympus suite completed with no failures/crashes
#   1 - Olympus suite failed, crashed, or did not complete
#   2 - Script/environment error (missing tool, download failed, etc.)

set -uo pipefail

REPO="bscotch/ganary"
ASSET_NAME="Ganary.zip"
APP_SUPPORT_DIR="$HOME/Library/Application Support/com.bscotch.ganary"
TEMP_DIR="$(pwd)/temp"
LOG_FILE="$TEMP_DIR/ganary.log"
RESULT_JSON="$APP_SUPPORT_DIR/Olympus_records/internal/ganary.raw.olympus.json"

TAG="${1:-}"

log() { echo "[run_ganary_olympus] $*"; }
die() { echo "[run_ganary_olympus] ERROR: $*" >&2; exit 2; }

# --- sanity checks -----------------------------------------------------

command -v gh >/dev/null 2>&1 || die "gh (GitHub CLI) is required but not found on PATH."
command -v jq >/dev/null 2>&1 || die "jq is required but not found on PATH."
command -v unzip >/dev/null 2>&1 || die "unzip is required but not found on PATH."

# --- 2. create/empty the temp path -------------------------------------

log "Preparing temp directory: $TEMP_DIR"
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"

# --- 3. empty the app support path --------------------------------------

log "Clearing app support directory: $APP_SUPPORT_DIR"
rm -rf "$APP_SUPPORT_DIR"
mkdir -p "$APP_SUPPORT_DIR"

# --- 3(4 in the request). resolve tag and download the release asset ----

if [ -z "$TAG" ]; then
    log "Resolving latest release tag for $REPO"
    TAG="$(gh release view --repo "$REPO" --json tagName -q .tagName)" \
        || die "Failed to resolve the latest release tag"
fi
log "Using release tag: $TAG"

log "Downloading '$ASSET_NAME' from release '$TAG' of $REPO"
gh release download "$TAG" \
    --repo "$REPO" \
    --pattern "$ASSET_NAME" \
    --dir "$TEMP_DIR" \
    --clobber \
    || die "Failed to download $ASSET_NAME from release $TAG"

ZIP_PATH="$TEMP_DIR/$ASSET_NAME"
[ -f "$ZIP_PATH" ] || die "Expected zip not found at $ZIP_PATH"

# --- 4. extract Ganary.app ----------------------------------------------

log "Extracting $ASSET_NAME"
unzip -q -o "$ZIP_PATH" -d "$TEMP_DIR" || die "Failed to extract $ZIP_PATH"

APP_PATH="$(find "$TEMP_DIR" -maxdepth 3 -iname "Ganary.app" -type d | head -n 1)"
[ -n "$APP_PATH" ] || die "Ganary.app not found after extraction"
log "Found app bundle: $APP_PATH"

# --- 5. disable gatekeeper check on the app ------------------------------

log "Removing quarantine attribute (disabling Gatekeeper check) on $APP_PATH"
xattr -rd com.apple.quarantine "$APP_PATH" 2>/dev/null || true

# --- 6. run the app with the required arguments --------------------------

EXECUTABLE_NAME="$(defaults read "$APP_PATH/Contents/Info" CFBundleExecutable 2>/dev/null)"
[ -n "$EXECUTABLE_NAME" ] || die "Could not determine CFBundleExecutable from Info.plist"
EXECUTABLE_PATH="$APP_PATH/Contents/MacOS/$EXECUTABLE_NAME"
[ -x "$EXECUTABLE_PATH" ] || die "Executable not found or not executable: $EXECUTABLE_PATH"

log "Running $EXECUTABLE_PATH --olympus_headless -output $LOG_FILE -debugoutput $LOG_FILE"
"$EXECUTABLE_PATH" "--olympus_headless" "-output" "$LOG_FILE" "-debugoutput" "$LOG_FILE"
RUN_EXIT_CODE=$?
log "App exited with code $RUN_EXIT_CODE"

# --- 7. confirm output file exists ---------------------------------------

if [ ! -f "$RESULT_JSON" ]; then
    die "Expected Olympus result file not found at: $RESULT_JSON"
fi
log "Found Olympus result file: $RESULT_JSON"

# --- 8. upload the log and result JSON back to the release ---------------

UPLOAD_LOG_PATH="$TEMP_DIR/mac.log"
UPLOAD_RESULT_PATH="$TEMP_DIR/mac_result.json"
cp "$LOG_FILE" "$UPLOAD_LOG_PATH" || die "Failed to stage $LOG_FILE for upload"
cp "$RESULT_JSON" "$UPLOAD_RESULT_PATH" || die "Failed to stage $RESULT_JSON for upload"

log "Uploading mac.log and mac_result.json to release $TAG of $REPO"
gh release upload "$TAG" \
    "$UPLOAD_LOG_PATH" \
    "$UPLOAD_RESULT_PATH" \
    --repo "$REPO" \
    --clobber \
    || die "Failed to upload log/result assets to release $TAG"

# --- 9. parse and validate the result JSON -------------------------------

SUCCESS=true

SUITE_NAME="$(jq -r '.name' "$RESULT_JSON")"
SUITE_STATUS="$(jq -r '.status' "$RESULT_JSON")"

if [ "$SUITE_STATUS" != "completed" ]; then
    echo "$SUITE_NAME : this suite did not complete."
    SUCCESS=false
fi

while IFS= read -r test_json; do
    TEST_STATUS="$(echo "$test_json" | jq -r '.status')"
    TEST_NAME="$(echo "$test_json" | jq -r '.name')"
    if [ "$TEST_STATUS" = "failed" ] || [ "$TEST_STATUS" = "crashed" ]; then
        echo "$TEST_NAME: $TEST_STATUS"
        SUCCESS=false
    fi
done < <(jq -c '.tests[]?' "$RESULT_JSON")

if [ "$SUCCESS" = true ]; then
    echo "Olympus test completed with no failure or crashes."
    exit 0
else
    exit 1
fi