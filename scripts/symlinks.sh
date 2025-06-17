#!/bin/zsh

set -o errexit
set -o nounset

echo "🔗 Creating directory symlinks..."

# Check if iCloud Drive exists
ICLOUD_PATH="/Users/singletoned/Library/Mobile Documents/com~apple~CloudDocs"
if [ ! -d "$ICLOUD_PATH" ]; then
    echo "❌ Error: iCloud Drive not found at $ICLOUD_PATH"
    echo "   Make sure iCloud Drive is set up and synced."
    exit 1
fi

if [ ! -d ~/cloud ]; then
    ln -s "$ICLOUD_PATH" ~/cloud
    echo "✅ Created ~/cloud symlink"
fi

if [ ! -d ~/src ]; then
    ln -s "$ICLOUD_PATH/src" ~/src
    echo "✅ Created ~/src symlink"
fi

echo "✅ Directory symlinks created successfully"
