# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(git common-aliases asdgasdg)
plugins=(git common-aliases)

source $ZSH/oh-my-zsh.sh

source $HOME/.homesick/repos/homeshick/homeshick.sh

PROMPT='%{$fg[gray]%}%m %{$fg[green]%}%c $(git_prompt_info)%{$fg[blue]%}λ%{$reset_color%} '
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}"

#eval `dircolors ~/.dircolors`

# vim movement
set -o vi
bindkey '^R' history-incremental-search-backward

# Customize to your needs...

# Load zsh-syntax-highlighting.
# source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
# # Load zsh-autosuggestions.
# source ~/.zsh/zsh-autosuggestions/autosuggestions.zsh

# zle-line-init() {
#     zle autosuggest-start
# }
# zle -N zle-line-init

bindkey '^f' vi-end-of-line

if [[ -f $HOME/.profile ]]
then
    source $HOME/.profile
fi

# eval $(dircolors ~/.dircolors)

alias staging-1="ssh -t staging-coruscant-1 'sudo tmux attach'"
alias production-2="ssh -t production-coruscant-2 'sudo tmux attach'"
alias production-2-tunnel="ssh -fN production-coruscant-2-tunnel"
alias venv="source ./.venv/bin/activate"
alias gs="git status"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

export PYTHONIOENCODING=utf-8:surrogateescape

source ~/.environment.sh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias here="x-terminal-emulator > /dev/null 2>&1 & disown"
DISABLE_AUTO_TITLE="true"
