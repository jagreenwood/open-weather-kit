#!/bin/bash
set -e

/workspaces/open-weather-kit/scripts/setup_local_dev.sh

SETTINGS_PATH="/home/vscode/.vscode-server/data/Machine/settings.json"
SWIFTLINT_KEY="swiftlint.path"
SWIFTLINT_VALUE="/home/vscode/.local/share/mise/installs/swiftlint/latest/swiftlint"

# Read the JSON string from the file
SETTINGS_FILE=$(cat "$SETTINGS_PATH")
# Update the value of the key
UPDATED_SETTINGS=$(echo "$SETTINGS_FILE" | jq --arg key "$SWIFTLINT_KEY" --arg value "$SWIFTLINT_VALUE" '.[$key] = $value')

echo "$UPDATED_SETTINGS" > "$SETTINGS_PATH"