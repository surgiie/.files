# --------------------------------------------------------------------------
# Environment Variables
#--------------------------------------------------------------------------
export VISUAL=nvim
export GIT_EDITOR=nvim
export EDITOR="$VISUAL"
export DOCKER_CLI_HINTS=false

export PYTHON=$(which python3)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/bin/nvim/bin"
export ZSH=/home/$USER/.oh-my-zsh
export PATH="$PATH:$PYENV_ROOT/versions/$(pyenv version | awk '{print $1}')/bin"
export PATH="$PATH:/home/$USER/.local/bin"
export PATH="/home/$USER/.config/composer/vendor/bin:$PATH"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# --------------------------------------------------------------------------
# File Concerns
# --------------------------------------------------------------------------
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

if [ ! -f ~/.local/bin/quake ]
then
    cd ~/.local/bin/
    wget https://raw.githubusercontent.com/surgiie/quake/refs/heads/main/quake &>/dev/null
    chmod +x ./quake
    cd - &>/dev/null
fi

# fixes docker desktop exec format error in wsl
if grep -i "microsoft" /proc/version >/dev/null; then
    if [ -f ~/.docker/config.json ]
    then
        sed -i 's/credsStore/credStore/g' ~/.docker/config.json
    fi
fi

# Load dconf settings for keyboard shortcuts on linux
if ! grep -i "microsoft" /proc/version >/dev/null; then
    dconf load / <"/home/$USER/.files/configs/dconf/keyboard.ini"
fi

#--------------------------------------------------------------------------
# Aliases
#--------------------------------------------------------------------------
alias k="kubectl "
alias vim="nvim"
alias fexplore="xdg-open"
alias copy="xclip -selection clipboard"
alias paste="xclip -o -selection clipboard"
alias sudo='sudo -E env "PATH=$PATH"'
cat(){
    if [[ " $* " == *" --pretty "* ]]; then
        command batcat $@
    else
        command cat $@
    fi
}
# --------------------------------------------------------------------------
# Theme
# --------------------------------------------------------------------------
ZSH_THEME="bullet-train"
if grep -i "microsoft" /proc/version >/dev/null; then
    BULLETTRAIN_PROMPT_CHAR="└>  "
else
    BULLETTRAIN_PROMPT_CHAR="╰─➤  "
fi
# fixes git branch not showing up in bullet train theme: https://github.com/ohmyzsh/ohmyzsh/issues/12328
zstyle ':omz:alpha:lib:git' async-prompt no
BULLETTRAIN_PROMPT_ORDER=(
    time
    dir
    git
)
BULLETTRAIN_TIME_BG=#87d7ff
BULLETTRAIN_DIR_BG=#ff8787
BULLETTRAIN_DIR_FG=black
BULLETTRAIN_GIT_BG=#fff
BULLETTRAIN_GIT_FG=black

# --------------------------------------------------------------------------
# Source files/partials
# --------------------------------------------------------------------------
source <(kubectl completion zsh)
source $ZSH/oh-my-zsh.sh

# source partials/helpers
for file in ~/.files/scripts/partials/*; do
    source $file
done


if [ ! -f ~/.fzf/install ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ ! -f ~/.fzf/plugins/fzf-tab/fzf-tab.plugin.zsh ]; then
   mkdir -p ~/.fzf/plugins
   git clone https://github.com/Aloxaf/fzf-tab ~/.fzf/plugins/fzf-tab
fi
source ~/.fzf/plugins/fzf-tab/fzf-tab.plugin.zsh

if [ ! -f ~/.oh-my-zsh/themes/bullet-train.zsh-theme ]; then
    mkdir -p ~/.oh-my-zsh/themes
    sudo apt-get install powerline -y
    git clone https://github.com/powerline/fonts.git --depth=1
    ./fonts/install.sh
    rm -rf fonts
    wget https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme ~/.oh-my-zsh/themes/bullet-train.zsh-theme
fi

if [ ! -f ~/.fzf/plugins/forgit/forgit.plugin.zsh ]; then
    mkdir -p ~/.fzf/plugins
    git clone https://github.com/wfxr/forgit.git ~/.fzf/plugins/forgit
fi
source ~/.fzf/plugins/forgit/forgit.plugin.zsh

if [ -f ~/.nvim-devcontainer/nvim-devcontainer ]; then
    source ~/.nvim-devcontainer/nvim-devcontainer
fi

if [ -f ~/.env ];
then
    set -o allexport
    source ~/.env
    set +o allexport
fi
