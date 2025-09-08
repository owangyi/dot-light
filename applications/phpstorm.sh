#!/usr/bin/env bash
set -euo pipefail

done_file="$HOME/.$(basename ${BASH_SOURCE[0]}).done"

if [ -f "$done_file" ]; then
    return
fi

color_print "[ Installing PhpStorm ]" $yellow   


brew_cask_install phpstorm &&

# Use user customized rather than default settings (sensitive) to avoid override by JetBrains update
# Note: This configuration may need to be updated for newer PhpStorm versions
# mkdir -p ~/Library/Application\ Support/JetBrains/PhpStorm2023.1/ &&
# cp /Applications/PhpStorm.app/Contents/bin/idea.properties ~/Library/Application\ Support/JetBrains/PhpStorm2023.1/ &&
# echo "idea.case.sensitive.fs=true" >> ~/Library/Application\ Support/JetBrains/PhpStorm2023.1/idea.properties

touch "$done_file"
