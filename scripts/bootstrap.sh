#!/bin/zsh

set -o errexit
set -o nounset

echo "🚀 Bootstrapping fresh macOS setup..."

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ Error: This script is designed for macOS only"
    exit 1
fi

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for this session
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        # Apple Silicon Mac
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f "/usr/local/bin/brew" ]]; then
        # Intel Mac
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    echo "✅ Homebrew installed successfully"
else
    echo "✅ Homebrew already installed"
fi

# Install Python 3 via Homebrew
if ! command -v python3 &> /dev/null; then
    echo "🐍 Installing Python 3..."
    brew install python
    echo "✅ Python 3 installed successfully"
else
    echo "✅ Python 3 already installed"
fi

# Verify installations
echo "🔍 Verifying installations..."
echo "Homebrew version: $(brew --version | head -n1)"
echo "Python version: $(python3 --version)"

echo "🎉 Bootstrap complete! You can now run 'make install' to set up your dotfiles."
