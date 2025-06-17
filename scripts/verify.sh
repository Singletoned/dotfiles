#!/bin/zsh

set -o errexit
set -o nounset

echo "🔍 Verifying dotfiles installation..."

# Check if key symlinks exist and are valid
check_symlink() {
    local target="$1"
    local description="$2"
    
    if [ -L "$target" ] && [ -e "$target" ]; then
        echo "✅ $description"
        return 0
    elif [ -e "$target" ]; then
        echo "⚠️  $description exists but is not a symlink"
        return 1
    else
        echo "❌ $description missing"
        return 1
    fi
}

# Check if file exists and is readable
check_file() {
    local target="$1"
    local description="$2"
    
    if [ -f "$target" ] && [ -r "$target" ]; then
        echo "✅ $description"
        return 0
    else
        echo "❌ $description missing or unreadable"
        return 1
    fi
}

# Check if directory exists
check_directory() {
    local target="$1"
    local description="$2"
    
    if [ -d "$target" ]; then
        echo "✅ $description"
        return 0
    else
        echo "❌ $description missing"
        return 1
    fi
}

VERIFICATION_FAILED=0

# Check key symlinks
check_symlink "$HOME/.zshrc" "zsh configuration" || VERIFICATION_FAILED=1
check_symlink "$HOME/.aliases" "shell aliases" || VERIFICATION_FAILED=1
check_symlink "$HOME/.config/starship.toml" "starship configuration" || VERIFICATION_FAILED=1

# Check virtual environments
check_directory "$HOME/.envs/default" "default Python environment" || VERIFICATION_FAILED=1
check_directory "$HOME/.envs/emacs" "emacs Python environment" || VERIFICATION_FAILED=1

# Check directory symlinks
check_symlink "$HOME/cloud" "iCloud Drive symlink" || VERIFICATION_FAILED=1
check_symlink "$HOME/src" "source directory symlink" || VERIFICATION_FAILED=1

# Check if virtual environment has required packages
if [ -d "$HOME/.envs/default" ]; then
    if "$HOME/.envs/default/bin/python" -c "import virtualenvwrapper" 2>/dev/null; then
        echo "✅ virtualenvwrapper installed in default environment"
    else
        echo "❌ virtualenvwrapper missing from default environment"
        VERIFICATION_FAILED=1
    fi
fi

# Test if shell configuration loads without errors
if zsh -c "source ~/.zshrc && echo 'Shell configuration loads successfully'" >/dev/null 2>&1; then
    echo "✅ Shell configuration loads without errors"
else
    echo "❌ Shell configuration has errors"
    VERIFICATION_FAILED=1
fi

if [ $VERIFICATION_FAILED -eq 0 ]; then
    echo ""
    echo "🎉 All verifications passed! Your dotfiles are properly installed."
    exit 0
else
    echo ""
    echo "⚠️  Some verifications failed. Please check the errors above."
    exit 1
fi