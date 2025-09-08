#!/usr/bin/env bash
set -euo pipefail

done_file=~/.$(basename ${BASH_SOURCE[0]}).done

if [ -f "$done_file" ]; then 
    log_info "Homebrew installation already completed, skipping..."
    return 0
fi

log_info "Starting Homebrew installation..."

# Install Xcode Command Line Tools
log_exec "xcode-select --install" "Installing Xcode Command Line Tools" || log_warning "Xcode Command Line Tools installation failed or already installed"

# Install Homebrew
log_exec "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"" "Installing Homebrew"

# Setup brew environment
log_info "Setting up Homebrew environment..."
brew_shellenv

# Add brew shellenv to .zprofile if not already present
if ! ([[ -e ~/.zprofile ]] && grep -q "brew shellenv" ~/.zprofile); then
    log_info "Adding Homebrew shellenv to .zprofile"
    echo "eval \"\$(${HOMEBREW_PREFIX}/bin/brew shellenv)\"" >> "${HOME}/.zprofile"
    log_success "Added Homebrew shellenv to .zprofile"
else
    log_info "Homebrew shellenv already configured in .zprofile"
fi

# Configure Homebrew
log_exec "brew analytics off" "Disabling Homebrew analytics"
log_exec "brew update" "Updating Homebrew"

# Mark as completed
touch "$done_file"
log_success "Homebrew installation completed successfully"
