#!/usr/bin/env bash
set -euo pipefail


done_file="$HOME/.$(basename ${BASH_SOURCE[0]}).done"

if [ -f "$done_file" ]; then
    return
fi

color_print "[ Installing Mas ]" $yellow   

brew install mas

color_print "We will open App Store. Please login with your Apple ID and quit." $green

acknowledge

open -W -a 'App Store' 

touch "$done_file"
