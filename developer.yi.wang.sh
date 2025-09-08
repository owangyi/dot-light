#!/usr/bin/env bash
set -euo pipefail


applications_dir="$root_dir/applications"


#source "${applications_dir}/yabai.sh"

# source "${applications_dir}/eudic.sh"
source "${applications_dir}/snipaste.sh"
source "${applications_dir}/gifox.sh"

source "${applications_dir}/iterm2.sh"  # Need more advanced configuration
# source "${applications_dir}/sublime.sh"  # 暂时跳过，下载失败
source "${applications_dir}/postman.sh"

source "${applications_dir}/nodejs.sh"


