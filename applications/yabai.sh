#!/usr/bin/env bash
set -euo pipefail

done_file="$HOME/.$(basename ${BASH_SOURCE[0]}).done"

if [ -f "$done_file" ]; then
    return
fi

color_print "[ Installing Yabai ]" $yellow   

# Install via Homebrew
brew install koekeishiya/formulae/yabai

# Start Yabai service
brew services start yabai

touch "$done_file"
