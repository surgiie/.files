# -------------------------------------------------------------------------
# Environment Variables
# -------------------------------------------------------------------------
export VISUAL=nvim
export GIT_EDITOR=nvim
export EDITOR="$VISUAL"
export DOCKER_CLI_HINTS=false
export PROJECTS="$HOME/projects"
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.npm/bin"
export PATH="$PATH:$HOME/.local/bin/nvim/bin"
export ZSH=/home/$USER/.oh-my-zsh

# -------------------------------------------------------------------------
# Init
# -------------------------------------------------------------------------
mkdir -p "$HOME/.local/bin"

if [ ! -f "$HOME/.oh-my-zsh/themes/bullet-train.zsh-theme" ]; then
   mkdir -p "$HOME/.oh-my-zsh/themes"
   curl -fsSL https://raw.githubusercontent.com/caiogondim/bullet-train.zsh/refs/heads/master/bullet-train.zsh-theme -o "$HOME/.oh-my-zsh/themes/bullet-train.zsh-theme"
fi
# -------------------------------------------------------------------------
# WSL
# -------------------------------------------------------------------------
if [[ -n "$WSL_DISTRO_NAME" ]] || grep -qi microsoft /proc/version 2>/dev/null; then
    [ -f "$HOME/.wslrc" ] && source "$HOME/.wslrc"
fi
# -------------------------------------------------------------------------
# Theme
# -------------------------------------------------------------------------
ZSH_THEME="bullet-train"
BULLETTRAIN_PROMPT_CHAR="╰─➤  "
BULLETTRAIN_GIT_PROMPT_CMD="\$(_omz_git_prompt_info)"
BULLETTRAIN_PROMPT_ORDER=(
  time
  dir
  git
  virtualenv
)
BULLETTRAIN_VIRTUALENV_BG=white
BULLETTRAIN_VIRTUALENV_FG=black
BULLETTRAIN_VIRTUALENV_PREFIX="🐍 "
BULLETTRAIN_VIRTUALENV_SHOW=true
BULLETTRAIN_TIME_BG=#95d7ff
BULLETTRAIN_DIR_BG=#ff8795
BULLETTRAIN_DIR_FG=black
BULLETTRAIN_GIT_BG=#fff
BULLETTRAIN_GIT_FG=black

source "$HOME/.oh-my-zsh/themes/bullet-train.zsh-theme"
# -------------------------------------------------------------------------
# Output Helpers
# -------------------------------------------------------------------------
yellow_bold() { printf "\e[1;33m%b\e[0m" "$*"; }

confirm() {
    local msg="${1:-Proceed?}"
    read -r "ans?$msg [y/N] "
    [[ "$ans" == "y" || "$ans" == "Y" ]]
}

ask_secret() {
    local prompt="$1"
    local input confirm

    read -s "input?$(yellow_bold '[INPUT]'): $prompt " >&2
    echo >&2

    echo "$input"
}

warn()    { printf "⚠️ WARN: %s\n"    "$*" >&2; }
error()   { printf "❌ ERROR: %s\n"   "$*" >&2; }

putenv() {
    if [[ -z "$1" || -z "$2" ]]; then
        echo "Usage: putenv VAR VALUE" >&2
        return 1
    fi
    fc -p /dev/null 0 0
    export "$1=$2"
    fc -P
}


# -------------------------------------------------------------------------
# Dev
# -------------------------------------------------------------------------
composer-link() {
    local package_path="$1"

    if [[ -z "$package_path" ]]; then
        echo "Usage: composer-link <package_path>"
        return 1
    fi

    if [[ ! -f "$package_path/composer.json" ]]; then
        echo "Error: composer.json not found in $package_path"
        return 1
    fi

    local name
    name=$(jq -r '.name' "$package_path/composer.json")

    if [[ "$name" == "null" || -z "$name" ]]; then
        echo "Error: Invalid or missing package name in composer.json"
        return 1
    fi

    composer config repositories.local '{"type": "path", "url": "'"$package_path"'"}' --file composer.json
    composer require "$name" @dev
}

npm-link() {
    local package_path="$1"

    if [[ -z "$package_path" ]]; then
        echo "Usage: npm-link <package_path>"
        return 1
    fi

    if [[ ! -f "$package_path/package.json" ]]; then
        echo "Error: package.json not found in $package_path"
        return 1
    fi

    local package_name
    package_name=$(node -p "require('$package_path/package.json').name" 2>/dev/null)

    if [[ -z "$package_name" || "$package_name" == "undefined" ]]; then
        echo "Error: Invalid or missing package name in package.json"
        return 1
    fi

    echo "Linking $package_name at $package_path"
    cd "$package_path" || return 1
    npm link

    cd - >/dev/null || return 1
    npm link "$package_name"
}

# -------------------------------------------------------------------------
# Dependency Checks / Auto-Install
# -------------------------------------------------------------------------
if ! command -v kantui &>/dev/null
then
    wget -qO "$HOME/.local/bin/kantui" https://raw.githubusercontent.com/surgiie/kantui/refs/heads/main/docker && chmod +x "$HOME/.local/bin/kantui"
fi

if [ ! -d ~/.config/yazi/flavors/monokai-vibrant.yazi ] && command -v ya >/dev/null 2>&1;
then
    ya pkg add sanjinso/monokai-vibrant
fi

# -------------------------------------------------------------------------
# Dotfiles
# -------------------------------------------------------------------------
if ! git -C "$HOME/.files" diff --quiet @{u}..HEAD 2>/dev/null; then
    warn "Your dotfiles repository has unpushed changes."
fi

# -------------------------------------------------------------------------
# Aliases
# -------------------------------------------------------------------------
alias ga='git add'
alias sudo='sudo -E env "PATH=$PATH"'
alias cat="bat -p"
## Usage
alias forgit="git-forgit"
alias todo="kantui"
alias copy="wl-copy"
alias k="kubectl"
alias ls="eza --icons=always"
alias fs="yazi"
alias fe="yazi"
alias ctx="kubectx"
alias ns="kubens"

# -------------------------------------------------------------------------
# Options
# -------------------------------------------------------------------------
setopt auto_cd
cdpath=(
    $HOME/projects
)

# -------------------------------------------------------------------------
# Functions
# -------------------------------------------------------------------------

bye(){
    if [ -f "$HOME/shutdown" ]; then
        source "$HOME/shutdown"
    fi
    shutdown now
}

virtualenv_make(){
    python -m venv .venv --copies
}

# -------------------------------------------------------------------------
# Completions
# -------------------------------------------------------------------------
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit -i

# fixes git branch not showing up in bullet train theme: https://github.com/ohmyzsh/ohmyzsh/issues/12336
zstyle ':omz:alpha:lib:git' async-prompt no

# -------------------------------------------------------------------------
# Prompt
# -------------------------------------------------------------------------
if [ -d "$HOME/.local/bin/kube-ps1" ]; then
    PROMPT='$(kube_ps1)(profile:$AWS_PROFILE)'$PROMPT
fi
# -------------------------------------------------------------------------
# Boot
# -------------------------------------------------------------------------
if [ -f "$HOME/boot" ]; then
    source "$HOME/boot"
fi
