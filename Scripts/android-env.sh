#!/usr/bin/env bash

# Change this if your SDK is elsewhere
export ANDROID_HOME="${ANDROID_HOME:-$HOME/Android/Sdk}"
export ANDROID_SDK_ROOT="$ANDROID_HOME"

# Find latest versions
LATEST_NDK=$(find "$ANDROID_HOME/ndk" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort -V | tail -n1)
LATEST_BUILD_TOOLS=$(find "$ANDROID_HOME/build-tools" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort -V | tail -n1)
LATEST_CMDLINE_TOOLS=$(find "$ANDROID_HOME/cmdline-tools" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort -V | tail -n1)

# NDK
if [[ -n "$LATEST_NDK" ]]; then
  export ANDROID_NDK_HOME="$LATEST_NDK"
  export NDK_HOME="$LATEST_NDK"
fi

# PATH
[[ -d "$ANDROID_HOME/platform-tools" ]] && PATH="$ANDROID_HOME/platform-tools:$PATH"
[[ -d "$ANDROID_HOME/emulator" ]] && PATH="$ANDROID_HOME/emulator:$PATH"
[[ -n "$LATEST_BUILD_TOOLS" ]] && PATH="$LATEST_BUILD_TOOLS:$PATH"
[[ -n "$LATEST_CMDLINE_TOOLS" ]] && PATH="$LATEST_CMDLINE_TOOLS/bin:$PATH"

export PATH

echo "Android environment loaded:"
echo "ANDROID_HOME=$ANDROID_HOME"
echo "ANDROID_NDK_HOME=${ANDROID_NDK_HOME:-<not found>}"
echo "Build Tools=${LATEST_BUILD_TOOLS:-<not found>}"
echo "Command-line Tools=${LATEST_CMDLINE_TOOLS:-<not found>}"

echo
command -v adb >/dev/null && echo "✓ adb: $(adb version | head -n1)"
command -v sdkmanager >/dev/null && echo "✓ sdkmanager found"
command -v avdmanager >/dev/null && echo "✓ avdmanager found"
command -v emulator >/dev/null && echo "✓ emulator found"
