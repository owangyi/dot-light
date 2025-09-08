#!/usr/bin/env bash
set -euo pipefail

done_file="$HOME/.$(basename ${BASH_SOURCE[0]}).done"

if [ -f "$done_file" ]; then
    return
fi

color_print "[ Installing Google Chrome ]" $yellow   

brew_cask_install google-chrome

# Note: chrome_pass.json file needs to be created manually if needed
# && sudo mkdir -p ~/Library/Google/Chrome/
# && sudo cp -r ./chrome_pass.json ~/Library/Google/Chrome/ # Control the chrome using Enterprise policy

color_print "We will open serveral websites in Chrome. Please configure them following your needs and quit Chrome by pressing Cmd+Q." $green

acknowledge

open -W -a 'Google Chrome' 

touch "$done_file"