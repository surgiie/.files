# shellcheck disable=all
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

export ZSH_AUTOSUGGEST_STRATEGY=(smart)
export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(forward-char end-of-line vi-forward-char vi-end-of-line)
export ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(forward-word vi-forward-word vi-forward-word-end vi-forward-blank-word vi-forward-blank-word-end)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export KUBECOLOR_PAGING=auto
export KUBECOLOR_PAGER="less -RF --quit-if-one-screen"
# -------------------------------------------------------------------------
# WezTerm shell integration (semantic zones for input detection)
# -------------------------------------------------------------------------
if [[ -n "$WEZTERM_EXECUTABLE" ]]; then
    _wezterm_integration="$(dirname "$WEZTERM_EXECUTABLE")/../etc/profile.d/wezterm.sh"
    [[ -f "$_wezterm_integration" ]] && source "$_wezterm_integration"
    unset _wezterm_integration
fi

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
  nix
  dir
  git
  virtualenv
)

BULLETTRAIN_NIX_BG=green
BULLETTRAIN_NIX_FG=black
prompt_nix() {
    [[ -z "$IN_NIX_SHELL" ]] && return
    prompt_segment "$BULLETTRAIN_NIX_BG" "$BULLETTRAIN_NIX_FG" " nix: ${NIX_PKG:-shell} "
}
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
# Dependency Checks / Auto-Install
# -------------------------------------------------------------------------
if ! command -v kantui &>/dev/null; then
    wget -qO "$HOME/.local/bin/kantui" https://raw.githubusercontent.com/surgiie/kantui/refs/heads/main/docker && chmod +x "$HOME/.local/bin/kantui"
fi

if [ ! -d ~/.config/yazi/flavors/monokai-vibrant.yazi ] && command -v ya >/dev/null 2>&1; then
    ya pkg add sanjinso/monokai-vibrant
fi

if [ ! -f "$HOME/.local/bin/hyprtoggle" ]; then
    mkdir -p "$HOME/.local/bin"
    curl -fsSLo "$HOME/.local/bin/hyprtoggle" https://raw.githubusercontent.com/surgiie/hyprtoggle/main/hyprtoggle
    chmod +x "$HOME/.local/bin/hyprtoggle"
fi

if command -v xdg-settings &>/dev/null; then
    xdg-settings set default-web-browser browse.desktop
fi

if [ ! -d "$HOME/.config/fuzzel/catppuccin" ]; then
    mkdir -p "$HOME/.config/fuzzel"
    git clone https://github.com/catppuccin/fuzzel.git /tmp/catppuccin-fuzzel
    cp -r /tmp/catppuccin-fuzzel/themes "$HOME/.config/fuzzel/catppuccin"
    rm -rf /tmp/catppuccin-fuzzel
fi

# -------------------------------------------------------------------------
# direnv
# -------------------------------------------------------------------------
if command -v direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

# -------------------------------------------------------------------------
# xdg default browser
# -------------------------------------------------------------------------
if command -v xdg-settings &>/dev/null; then
    xdg-settings set default-web-browser browse.desktop
fi

# -------------------------------------------------------------------------
# Functions
# -------------------------------------------------------------------------
source "$HOME/.zsh_functions"

# -------------------------------------------------------------------------
# Dotfiles
# -------------------------------------------------------------------------
if ! git -C "$HOME/.files" diff --quiet @{u}..HEAD 2>/dev/null; then
    warn "Your dotfiles repository has unpushed changes."
fi

# -------------------------------------------------------------------------
# History
# -------------------------------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# -------------------------------------------------------------------------
# Aliases
# -------------------------------------------------------------------------
alias k="kubecolor"
alias sudo='sudo -E env "PATH=$PATH"'
alias cat="bat -p"
alias forgit="git-forgit"
alias todo="kantui"
alias copy="wl-copy"
alias ls="eza --icons=always"
alias ll="eza --icons=always -la"
alias fs="yazi"
alias fe="yazi"

# -------------------------------------------------------------------------
# Options
# -------------------------------------------------------------------------
setopt auto_cd
cdpath=(
    $HOME/projects
)

# fixes git branch not showing up in bullet train theme: https://github.com/ohmyzsh/ohmyzsh/issues/12336
zstyle ':omz:alpha:lib:git' async-prompt no
# -------------------------------------------------------------------------
# Prompt
# -------------------------------------------------------------------------
function _custom_prompt_prefix() {
    local prompt_parts=""

    # Add kube_ps1 if available and has a valid context
    if typeset -f kube_ps1 > /dev/null; then
        # Only show if kubectl has a current context
        if command -v kubectl &>/dev/null && kubectl config current-context &>/dev/null; then
            local kube_info="$(kube_ps1)"
            if [[ -n "$kube_info" ]]; then
                prompt_parts+="$kube_info"
            fi
        fi
    fi

    # Add AWS profile if set
    if [[ -n "$AWS_PROFILE" ]]; then
        prompt_parts+="(profile:$AWS_PROFILE)"
    fi

    echo -n "$prompt_parts"
}

if [ -f "$HOME/.local/bin/kube-ps1/kube-ps1.sh" ]; then
    source "$HOME/.local/bin/kube-ps1/kube-ps1.sh"
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _kube_ps1_reset_cache
    function _kube_ps1_reset_cache() {
        _KUBE_PS1_LAST_TIME=0
    }
fi

PROMPT='$(_custom_prompt_prefix)'$PROMPT
# -------------------------------------------------------------------------
# fzf shell integration (ALT+C dir jump, ** completion)
# -------------------------------------------------------------------------
if command -v fzf &>/dev/null; then
    source <(fzf --zsh)
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
    if command -v fd &>/dev/null; then
        export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"
    fi
fi

# -------------------------------------------------------------------------
# kubectl completion
# -------------------------------------------------------------------------
if command -v kubectl &>/dev/null; then
    source <(kubectl completion zsh)
fi

# -------------------------------------------------------------------------
# Completions (must run after all completion definitions above)
# -------------------------------------------------------------------------
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit -i
compdef _kubectl k kubecolor

_json_pipe() {
    local cmd="${words[2]}"
    (( CURRENT-- ))
    shift words
    _normal
}
compdef _json_pipe json:pipe


# -------------------------------------------------------------------------
# fzf-tab (wraps all zsh completions with fzf, must come after compinit)
# -------------------------------------------------------------------------
if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/fzf-tab" ]]; then
    git clone https://github.com/Aloxaf/fzf-tab "$HOME/.oh-my-zsh/custom/plugins/fzf-tab"
fi
source "$HOME/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh"
if [[ -f /run/current-system/sw/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /run/current-system/sw/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f /run/current-system/sw/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /run/current-system/sw/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

_zsh_autosuggest_strategy_smart() {
    local last_word="${1##* }"
    if [[ "$1" == *' ' ]]; then
        _zsh_autosuggest_strategy_history "$1"
        [[ -n "$suggestion" ]] && return
        _zsh_autosuggest_strategy_completion "$1"
    elif [[ "$last_word" == -* ]]; then
        _zsh_autosuggest_strategy_completion "$1"
        [[ -n "$suggestion" ]] && return
        _zsh_autosuggest_strategy_history "$1"
    else
        _zsh_autosuggest_strategy_wordhistory "$1"
        [[ -n "$suggestion" ]] && return
        _zsh_autosuggest_strategy_history "$1"
    fi
}

_zsh_autosuggest_strategy_wordhistory() {
    local prefix="$1"
    local last_word="${prefix##* }"
    [[ -z "$last_word" ]] && return
    local match
    match=$(fc -ln 1 | tr ' ' '\n' | grep "^${last_word}[^/]*$" | awk '{ if (length < min || min == 0) { min = length; best = $0 } } END { print best }')
    [[ -n "$match" ]] && suggestion="${prefix%$last_word}$match"
}

# -------------------------------------------------------------------------
# Boot
# -------------------------------------------------------------------------
if [ -f "$HOME/boot" ]; then
    source "$HOME/boot"
fi

bindkey '^_' undo
bindkey '^[l' forward-word
