#!/usr/bin/env bash
set -euo pipefail

done_file="$HOME/.$(basename ${BASH_SOURCE[0]}).done"

if [ -f "$done_file" ]; then
    return
fi

color_print "[ Installing Composer ]" $yellow   

# Install Composer via Homebrew
brew install composer

composer config -g allow-plugins false

touch "$done_file"
