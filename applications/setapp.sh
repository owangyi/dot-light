#!/usr/bin/env bash
set -euo pipefail

done_file="$HOME/.$(basename ${BASH_SOURCE[0]}).done"

if [ -f "$done_file" ]; then
    return
fi

color_print "[ Installing Setapp ]" $yellow   

brew_cask_install setapp

touch "$done_file"
