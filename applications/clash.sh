#!/usr/bin/env bash
set -euo pipefail

done_file="$HOME/.$(basename ${BASH_SOURCE[0]}).done"

if [ -f "$done_file" ]; then
    return
fi

color_print "[ Installing ClashX ]" $yellow   

brew_cask_install clash-verge-rev

touch "$done_file"
