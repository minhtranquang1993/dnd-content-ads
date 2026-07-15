#!/bin/bash
# ============================================================
# DND Ads — Video Transcription via Deepgram REST API
# ============================================================
# Usage: bash transcribe_video.sh <video_path>
#
# Reads API key from credentials/deepgram_api_key.txt
# Outputs transcript text to stdout
#
# Supported formats: mp4, mp3, wav, m4a, mov, webm, ogg, flac
# ============================================================

set -euo pipefail

# --- Resolve python command (Windows Git Bash uses 'python', not 'python3') ---
if command -v python3 >/dev/null 2>&1; then
    PY=python3
elif command -v python >/dev/null 2>&1; then
    PY=python
else
    echo "❌ Error: python not found on PATH" >&2
    exit 1
fi

# --- Validate input ---
if [ -z "${1:-}" ]; then
    echo "❌ Error: No video path provided"
    echo "Usage: bash transcribe_video.sh <video_path>"
    exit 1
fi

VIDEO_PATH="$1"

if [ ! -f "$VIDEO_PATH" ]; then
    echo "❌ Error: File not found: $VIDEO_PATH"
    exit 1
fi

# --- Load API key ---
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
API_KEY_FILE="$SCRIPT_DIR/../credentials/deepgram_api_key.txt"

if [ ! -f "$API_KEY_FILE" ]; then
    echo "❌ Error: API key file not found: $API_KEY_FILE"
    echo "Please create the file with your Deepgram API key."
    exit 1
fi

API_KEY=$(cat "$API_KEY_FILE" | tr -d '[:space:]')

if [ -z "$API_KEY" ]; then
    echo "❌ Error: API key is empty"
    exit 1
fi

# --- Auto-detect content type ---
EXTENSION="${VIDEO_PATH##*.}"
EXTENSION=$(echo "$EXTENSION" | tr '[:upper:]' '[:lower:]')

case "$EXTENSION" in
    mp4)  CONTENT_TYPE="video/mp4" ;;
    mp3)  CONTENT_TYPE="audio/mpeg" ;;
    wav)  CONTENT_TYPE="audio/wav" ;;
    m4a)  CONTENT_TYPE="audio/m4a" ;;
    mov)  CONTENT_TYPE="video/quicktime" ;;
    webm) CONTENT_TYPE="video/webm" ;;
    ogg)  CONTENT_TYPE="audio/ogg" ;;
    flac) CONTENT_TYPE="audio/flac" ;;
    *)    CONTENT_TYPE="application/octet-stream" ;;
esac

# --- Get file size for progress info ---
FILE_SIZE=$(stat -c%s "$VIDEO_PATH" 2>/dev/null || stat -f%z "$VIDEO_PATH" 2>/dev/null || echo "unknown")
echo "📁 File: $(basename "$VIDEO_PATH")" >&2
echo "📦 Size: $FILE_SIZE bytes" >&2
echo "🎤 Content-Type: $CONTENT_TYPE" >&2
echo "🔄 Transcribing via Deepgram API (nova-3)..." >&2

# --- Call Deepgram API ---
RESPONSE=$(curl -s \
    --request POST \
    --header "Authorization: Token $API_KEY" \
    --header "Content-Type: $CONTENT_TYPE" \
    --data-binary "@$VIDEO_PATH" \
    --url 'https://api.deepgram.com/v1/listen?model=nova-3&smart_format=true&detect_language=true&paragraphs=true&punctuate=true')

# --- Check for API errors ---
ERROR=$(echo "$RESPONSE" | "$PY" -c "
import sys, json
try:
    data = json.load(sys.stdin)
    if 'err_code' in data:
        print(f\"Error {data['err_code']}: {data.get('err_msg', 'Unknown error')}\")
    elif 'error' in data:
        print(f\"Error: {data['error']}\")
except:
    pass
" 2>/dev/null || true)

if [ -n "$ERROR" ]; then
    echo "❌ Deepgram API Error: $ERROR" >&2
    exit 1
fi

# --- Extract transcript ---
TRANSCRIPT=$(echo "$RESPONSE" | "$PY" -c "
import sys, json
data = json.load(sys.stdin)
try:
    # Try paragraphs first (more structured)
    paragraphs = data['results']['channels'][0]['alternatives'][0]['paragraphs']['transcript']
    print(paragraphs)
except (KeyError, IndexError):
    try:
        # Fallback to plain transcript
        text = data['results']['channels'][0]['alternatives'][0]['transcript']
        print(text)
    except (KeyError, IndexError):
        print('❌ Could not extract transcript from response')
        sys.exit(1)
")

# --- Detect language ---
LANGUAGE=$(echo "$RESPONSE" | "$PY" -c "
import sys, json
try:
    data = json.load(sys.stdin)
    lang = data['results']['channels'][0]['detected_language']
    print(f'🌐 Detected language: {lang}')
except:
    print('🌐 Language: auto-detected')
" 2>/dev/null || echo "🌐 Language: unknown")

echo "$LANGUAGE" >&2
echo "✅ Transcription complete!" >&2
echo "" >&2

# --- Output transcript to stdout ---
echo "$TRANSCRIPT"
