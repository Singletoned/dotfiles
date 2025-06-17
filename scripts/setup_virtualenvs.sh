#!/bin/zsh

set -o errexit
set -o nounset

echo "🐍 Setting up Python virtual environments..."

# Check dependencies
if ! command -v python3 &> /dev/null; then
    echo "❌ Error: python3 is required but not found. Run 'make bootstrap' first."
    exit 1
fi

if [ ! -d ~/.envs ]; then
    mkdir ~/.envs

    export PIP_REQUIRE_VIRTUALENV=false
    export VIRTUALENVWRAPPER_PYTHON=python3
    export WORKON_HOME=$HOME/.envs

fi

if [ ! -d ~/.envs/default ]; then
    python3 -m venv ~/.envs/default
    ~/.envs/default/bin/python3 -m pip install --upgrade ipython virtualenvwrapper
fi

if [ ! -d ~/.envs/emacs ]; then
    python3 -m venv ~/.envs/emacs
    ~/.envs/emacs/bin/python3 -m pip install --upgrade black flake8 isort
fi

echo "✅ Virtual environments setup complete"
