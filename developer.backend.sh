#!/usr/bin/env bash
set -euo pipefail

# 这里需要加引号，因为如果 $root_dir 或路径中包含空格，不加引号会导致路径被拆分，脚本出错。
applications_dir="$root_dir/applications"

# Need more advanced configuration
source "${applications_dir}/php.sh"
source "${applications_dir}/phpstorm.sh"
source "${applications_dir}/composer.sh"
source "${applications_dir}/mysql.sh"
source "${applications_dir}/mysqlworkbench.sh"
source "${applications_dir}/sequel-ace.sh"
