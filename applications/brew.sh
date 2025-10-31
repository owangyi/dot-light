#!/usr/bin/env bash
set -euo pipefail

done_file=~/.$(basename ${BASH_SOURCE[0]}).done

if [ -f "$done_file" ]; then 
    return 0
fi

# Install Xcode Command Line Tools
xcode-select --install || true

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Setup brew environment
brew_shellenv

# Add brew shellenv to .zprofile if not already present
if ! ([[ -e ~/.zprofile ]] && grep -q "brew shellenv" ~/.zprofile); then
    echo "eval \"\$(${HOMEBREW_PREFIX}/bin/brew shellenv)\"" >> "${HOME}/.zprofile"
fi

# Configure Homebrew
brew analytics off
brew update

# Mark as completed
touch "$done_file"
