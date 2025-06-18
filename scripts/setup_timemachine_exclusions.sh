#!/bin/bash

set -e

echo "🕐 Setting up Time Machine exclusions..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_step() {
    echo -e "${GREEN}[EXCLUSION]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to add exclusion if path exists
add_exclusion_if_exists() {
    local path="$1"
    local description="$2"
    
    if [ -e "$path" ]; then
        sudo tmutil addexclusion -p "$path"
        print_step "Added: $description"
    else
        print_warning "Skipped (not found): $description"
    fi
}

# Development tools and containers
print_step "Adding development tool exclusions..."
add_exclusion_if_exists ~/Library/Group\ Containers/HUAQ24HBR6.dev.orbstack/data "OrbStack data"
add_exclusion_if_exists ~/OrbStack "OrbStack directory"
add_exclusion_if_exists ~/.docker "Docker data"
add_exclusion_if_exists ~/Library/Containers/com.docker.docker "Docker Desktop containers"

# Node.js and package managers
print_step "Adding Node.js exclusions..."
add_exclusion_if_exists ~/.npm "npm cache"
add_exclusion_if_exists ~/.yarn "Yarn cache"
add_exclusion_if_exists ~/.pnpm-store "pnpm store"

# Python environments
print_step "Adding Python exclusions..."
add_exclusion_if_exists ~/.pyenv "pyenv installations"
add_exclusion_if_exists ~/.envs "Python virtual environments"

# Large cache directories
print_step "Adding cache exclusions..."
add_exclusion_if_exists ~/Library/Caches "User library caches"
add_exclusion_if_exists ~/.cache "User cache directory"

# Temporary and download directories
print_step "Adding temporary file exclusions..."
add_exclusion_if_exists ~/Downloads "Downloads folder"
add_exclusion_if_exists ~/.Trash "Trash"
add_exclusion_if_exists /tmp "System temp directory"

# IDE and editor caches
print_step "Adding IDE exclusions..."
add_exclusion_if_exists ~/.vscode/extensions "VS Code extensions"
add_exclusion_if_exists ~/Library/Application\ Support/Code/User/workspaceStorage "VS Code workspace storage"
add_exclusion_if_exists ~/.emacs.d/elpa "Emacs packages"

# Homebrew
print_step "Adding Homebrew exclusions..."
add_exclusion_if_exists /opt/homebrew/var/homebrew/locks "Homebrew locks (Apple Silicon)"
add_exclusion_if_exists /usr/local/var/homebrew/locks "Homebrew locks (Intel)"

# Xcode
print_step "Adding Xcode exclusions..."
add_exclusion_if_exists ~/Library/Developer/Xcode/DerivedData "Xcode derived data"
add_exclusion_if_exists ~/Library/Developer/CoreSimulator "iOS Simulator data"

echo
echo "🎉 Time Machine exclusions configured!"
echo
echo "To view current exclusions, run:"
echo "  tmutil listexclusions"