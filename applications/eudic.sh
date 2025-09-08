#!/usr/bin/env bash
set -euo pipefail

done_file="$HOME/.$(basename ${BASH_SOURCE[0]}).done"

if [ -f "$done_file" ]; then
    return
fi

color_print "[ Installing Eudic ]" $yellow   

brew_cask_install eudic

color_print "We will open Eudic. Please login with your Eudic ID and quit." $green

acknowledge

open -W -a 'Eudic' 

touch "$done_file"
