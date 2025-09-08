#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd)"

export root_dir

source "$root_dir/helper.sh"

# Setup logging
setup_logging

color_print "Welcome to dotfile setup," "$blue"
# log_info "Welcome to dotfile setup"

# log_info "Loading developer configuration..."
source "$root_dir/developer.sh"

# log_info "Selecting team configuration..."
which_team
log_info "Selected team: $team"

case "$team" in
    "backend")
        log_info "Loading backend developer configuration..."
        source "$root_dir/developer.backend.sh"
        ;;
    "frontend")
        log_info "Loading frontend developer configuration..."
        source "$root_dir/developer.frontend.sh"
        ;;
    "devops")
        log_info "Loading devops developer configuration..."
        source "$root_dir/developer.devops.sh"
        ;;
    *)
        log_error "Invalid team: $team"
        color_print "Invalid team: $team" "$red"
        exit 1
        ;;
esac

personal_file="$root_dir/developer.${USER}.sh"

if file_exists "$personal_file"; then
    log_info "Loading personal configuration: $personal_file"
    source "$personal_file"
else
    log_info "No personal configuration file found: $personal_file"
fi

log_success "Workstation initialization completed successfully!"
color_print "Your workstation has been initialized, enjoy your work!" "$green"