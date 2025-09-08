#!/usr/bin/env bash
set -euo pipefail

applications_dir="$root_dir/applications"

# source "${applications_dir}/clash.sh"

source "${applications_dir}/macos.sh"
source "${applications_dir}/mas.sh"

# shellcheck source=applications/brew.sh
#ource "${applications_dir}/brew.sh"

source "${applications_dir}/chrome.sh"
source "${applications_dir}/firefox.sh"

source "${applications_dir}/surge.sh"
source "${applications_dir}/setapp.sh"

source "${applications_dir}/git.sh"
source "${applications_dir}/fork.sh"

source "${applications_dir}/wechat.sh"
source "${applications_dir}/slack.sh"
# source "${applications_dir}/telegram.sh"

source "${applications_dir}/notion.sh"
# source "${applications_dir}/typora.sh"
source "${applications_dir}/cursor.sh"

