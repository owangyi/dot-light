#!/usr/bin/env bash
set -euo pipefail

done_file="$HOME/.$(basename ${BASH_SOURCE[0]}).done"

if [ -f "$done_file" ]; then
    return
fi

color_print "[ Installing PHP ]" $yellow   

# Install PHP via Homebrew
brew install php@8.3 &&
brew link --force php@8.3 &&
pecl channel-update pecl.php.net &&
pecl install redis &&
pecl install xdebug &&
pecl install yaml

touch "$done_file"
