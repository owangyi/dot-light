#!/usr/bin/env bash
set -euo pipefail

: "${team:=}"
: "${user_name:=}"
: "${user_email:=}"
# shellcheck disable=SC2034
red=$(tput setaf 1)
# shellcheck disable=SC2034
green=$(tput setaf 2)
# shellcheck disable=SC2034
blue=$(tput setaf 4)
# shellcheck disable=SC2034
yellow=$(tput setaf 3)
# shellcheck disable=SC2034
bold=$(tput bold)
reset=$(tput sgr0)

# Print message with color
color_print() {
    printf "%s%s%s\n" "$2" "$1" "$reset"
}

# Logging functions
setup_logging() {
    local log_dir="${HOME}/.dotfile-logs"
    local timestamp=$(date '+%Y%m%d_%H%M%S')
    
    # Create log directory if it doesn't exist
    mkdir -p "$log_dir"
    
    # Set log file path
    export LOG_FILE="${log_dir}/dotfile_setup_${timestamp}.log"
    
    # Log initial message
    log_info "Starting dotfile setup at $(date)"
    log_info "Log file: $LOG_FILE"
}

log_info() {
    local message="[INFO] $(date '+%Y-%m-%d %H:%M:%S') - $1"
    echo "$message" | tee -a "$LOG_FILE"
}

log_error() {
    local message="[ERROR] $(date '+%Y-%m-%d %H:%M:%S') - $1"
    echo "$message" | tee -a "$LOG_FILE" >&2
    color_print "$1" "$red"
}

log_success() {
    local message="[SUCCESS] $(date '+%Y-%m-%d %H:%M:%S') - $1"
    echo "$message" | tee -a "$LOG_FILE"
    color_print "$1" "$green"
}

log_warning() {
    local message="[WARNING] $(date '+%Y-%m-%d %H:%M:%S') - $1"
    echo "$message" | tee -a "$LOG_FILE"
    color_print "$1" "$yellow"
}

# Command execution with logging
log_exec() {
    local cmd="$1"
    local description="$2"
    
    log_info "Executing: $description"
    log_info "Command: $cmd"
    
    if eval "$cmd" 2>&1 | tee -a "$LOG_FILE"; then
        log_success "Completed: $description"
        return 0
    else
        local exit_code=$?
        log_error "Failed: $description (exit code: $exit_code)"
        return $exit_code
    fi
}

which_team() {
    if [ -z "$team" ]; then
    PS3="Which team are you in? "
    select team in "backend" "frontend" "devops"; do
        break
    done
    fi
}

get_user_info() {
    if [ -z "$user_name" ]; then
        if [ -t 0 ]; then
            read -p "What's your full name? (e.g. John Doe): " user_name || user_name="John Doe"
        else
            user_name="John Doe"
        fi
    fi

    if [ -z "$user_email" ]; then
        if [ -t 0 ]; then
            read -rp "What is your work email? (e.g. john.doe@example.com): " user_email || user_email="john.doe@example.com"
        else
            user_email="john.doe@example.com"
        fi
    fi
}

acknowledge() {
    read -rp "Press Enter to continue..."
}

file_exists() {
    [ -f "$1" ]
}

is_apple_silicon()
{
  [ "$(/usr/bin/uname -m)" == "arm64" ]
}

brew_shellenv()
{
  # It will export env variable: HOMEBREW_PREFIX, HOMEBREW_CELLAR, HOMEBREW_REPOSITORY, HOMEBREW_SHELLENV_PREFIX
  # It will add path: $PATH, $MANPATH, $INFOPATH
  if is_apple_silicon; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
  else
      eval "$(/usr/local/bin/brew shellenv)"
  fi
}

brew_cask_install() {
    if (($# == 0)); then
        echo "Usage: brew_cask_install <app_name>"
        echo "e.g. brew_cask_install notion"
        return 1
    fi

    local app="$1"
    
    # 检查是否已通过 Homebrew 安装
    if brew list --cask "$app" &>/dev/null; then
        printf "%s%s is already installed via Homebrew, skipping...%s\n" "$green" "$app" "$reset"
        return 0
    fi
    
    # 检查应用是否在 Homebrew 中可用
    if ! brew search --cask "$app" | grep -q "^$app$"; then
        printf "%s%s is not available in Homebrew cask%s\n" "$red" "$app" "$reset"
        return 1
    fi
    
    # 检查是否已通过其他方式安装（如 App Store）
    local app_name=""
    case "$app" in
        "wechat")
            app_name="WeChat.app"
            ;;
        "notion")
            app_name="Notion.app"
            ;;
        "slack")
            app_name="Slack.app"
            ;;
        "telegram")
            app_name="Telegram.app"
            ;;
        "firefox")
            app_name="Firefox.app"
            ;;
        "google-chrome")
            app_name="Google Chrome.app"
            ;;
        "cursor")
            app_name="Cursor.app"
            ;;
        "fork")
            app_name="Fork.app"
            ;;
        "typora")
            app_name="Typora.app"
            ;;
        "surge")
            app_name="Surge.app"
            ;;
        "setapp")
            app_name="Setapp.app"
            ;;
        "iterm2")
            app_name="iTerm.app"
            ;;
        "sublime-text")
            app_name="Sublime Text.app"
            ;;
        "phpstorm")
            app_name="PhpStorm.app"
            ;;
        "mysqlworkbench")
            app_name="MySQLWorkbench.app"
            ;;
        "sequel-ace")
            app_name="Sequel Ace.app"
            ;;
        "postman")
            app_name="Postman.app"
            ;;
        "snipaste")
            app_name="Snipaste.app"
            ;;
        "gifox")
            app_name="Gifox.app"
            ;;
        "clash")
            app_name="ClashX.app"
            ;;
        "yabai")
            app_name="Yabai.app"
            ;;
        "eduic")
            app_name="Eduic.app"
            ;;
    esac
    
    if [ -n "$app_name" ] && [ -d "/Applications/$app_name" ]; then
        printf "%s%s is already installed (found %s), skipping...%s\n" "$green" "$app" "$app_name" "$reset"
        return 0
    fi
    
    # 安装应用
    printf "%sInstalling %s...%s\n" "$blue" "$app" "$reset"
    brew install --cask "$app"
}

brew_cask_multiple_install() {
    for app in "$@"; do
        brew_cask_install "$app"
    done
}


