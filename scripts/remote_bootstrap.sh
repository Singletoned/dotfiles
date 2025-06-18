#!/bin/bash

set -e

echo "🚀 Starting dotfiles bootstrap..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
    echo -e "${GREEN}[STEP]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is designed for macOS only"
    exit 1
fi

# Check if user has admin privileges
if ! groups | grep -q '\badmin\b'; then
    print_error "This script requires administrator privileges"
    print_error "Please ensure your user account is an Administrator"
    exit 1
fi

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    print_step "Installing Homebrew..."
    print_warning "Homebrew installation requires sudo access"
    print_warning "You may be prompted for your password"
    
    # Install Homebrew - it will handle the sudo prompts itself
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for this session
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    print_step "Homebrew already installed ✓"
fi

# Install git and GitHub CLI
print_step "Installing git and GitHub CLI..."
brew install git gh

# Generate SSH key if it doesn't exist
SSH_KEY_PATH="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY_PATH" ]; then
    print_step "Generating SSH key..."
    
    # Get email for SSH key
    echo -n "Enter your email address for the SSH key: "
    read email
    
    ssh-keygen -t ed25519 -C "$email" -f "$SSH_KEY_PATH" -N ""
    
    # Start SSH agent and add key
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEY_PATH"
    
    print_step "SSH key generated at $SSH_KEY_PATH"
else
    print_step "SSH key already exists ✓"
    # Make sure it's added to ssh-agent
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEY_PATH" 2>/dev/null || true
fi

# GitHub CLI authentication
print_step "Setting up GitHub authentication..."
if ! gh auth status &> /dev/null; then
    print_step "Starting GitHub CLI authentication..."
    gh auth login --git-protocol ssh --web
    
    # Add SSH key to GitHub
    print_step "Adding SSH key to GitHub..."
    HOSTNAME=$(hostname)
    gh ssh-key add "$SSH_KEY_PATH.pub" --title "$HOSTNAME"
    print_step "SSH key added to GitHub ✓"
else
    print_step "Already authenticated with GitHub ✓"
    
    # Still try to add the SSH key in case it's not there
    HOSTNAME=$(hostname)
    gh ssh-key add "$SSH_KEY_PATH.pub" --title "$HOSTNAME" 2>/dev/null || print_warning "SSH key might already be added to GitHub"
fi

# Clone dotfiles repository
DOTFILES_DIR="$HOME/.dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    print_step "Cloning dotfiles repository..."
    git clone git@github.com:singletoned/.dotfiles.git "$DOTFILES_DIR"
else
    print_step "Dotfiles repository already exists ✓"
fi

# Change to dotfiles directory and run setup
cd "$DOTFILES_DIR"

print_step "Running dotfiles installation..."
make install

print_step "🎉 Bootstrap complete!"
echo
echo "Your dotfiles have been installed. You may need to:"
echo "1. Restart your terminal or run 'source ~/.zshrc'"
echo "2. Complete any manual setup steps for specific applications"
echo "3. Review the installed configurations in ~/.config/"