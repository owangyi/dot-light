#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd)"

export root_dir

source "$root_dir/helper.sh"

color_print "Welcome to dotfile setup," "$blue"

source "$root_dir/developer.sh"

which_team

case "$team" in
    "backend")
        source "$root_dir/developer.backend.sh"
        ;;
    "frontend")
        source "$root_dir/developer.frontend.sh"
        ;;
    "devops")
        source "$root_dir/developer.devops.sh"
        ;;
    *)
        color_print "Invalid team: $team" "$red"
        exit 1
        ;;
esac

personal_file="$root_dir/developer.${USER}.sh"

if file_exists "$personal_file"; then
    source "$personal_file"
fi

color_print "Your workstation has been initialized, enjoy your work!" "$green"