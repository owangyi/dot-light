#!/usr/bin/env bash
set -euo pipefail

done_file="$HOME/.$(basename ${BASH_SOURCE[0]:-git.sh}).done"

if [ -f "$done_file" ]; then
    return
fi

color_print "[ Installing Git ]" $yellow   

brew install git git-lfs 
sudo git lfs install && git config --global protocol.version 2

get_user_info

# Configure Git (you may want to customize these)
git config --global user.name ${user_name}
git config --global user.email ${user_email}

git config --global init.defaultBranch master
git config --global pull.rebase true

touch "$done_file"
