# Path to your oh-my-zsh configuration.
# export ZSH=/nix/store/f35gv4zwr4z873msdzsvi7n81f33lrc5-oh-my-zsh-2018-4-25/share/oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

if [[ -f $HOME/.profile ]]; then
    source $HOME/.profile
fi

export ZSH_THEME=""
# export ZSH=$OH_MY_ZSH


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
#plugins=(git vi-mode zsh-fzf-history-search)
plugins=(git vi-mode zaw)

source $ZSH/oh-my-zsh.sh

source $HOME/.homesick/repos/homeshick/homeshick.sh

function my_prompt_hints() {
    if (command -v prompt_hints &> /dev/null); then
        prompt_hints
    fi
}

PROMPT='$(my_prompt_hints)%{$fg[green]%}%c $(git_prompt_info)%{$fg[blue]%}'$'\n''λ%{$reset_color%} '
#PROMPT='%m [$IN_NIX_SHELL] %{$fg[green]%}%c $(git_prompt_info)%{$fg[blue]%}λ '
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}"

#eval `dircolors ~/.dircolors`

# vim movement
# set -o vi
# bindkey '^R' history-incremental-search-backward

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

# eval $(dircolors ~/.dircolors)

alias staging-1="ssh -t staging-coruscant-1 'sudo tmux attach'"
alias production-2="ssh -t production-coruscant-2 'sudo tmux attach'"
alias production-2-tunnel="ssh -fN production-coruscant-2-tunnel"
alias venv="source ./.venv/bin/activate"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# Run the command given by "$@" in the background
silent_background() {
    setopt local_options no_notify no_monitor
    # We'd use &| to background and disown, but incompatible with bash, so:
    "$@" >/dev/null 2>&1 &
    disown &>/dev/null  # Close STD{OUT,ERR} to prevent whine if job has already completed
}

alias here="silent_background kitty"
DISABLE_AUTO_TITLE="true"

alias ls="ls -G --color=auto"
alias ipy="nix-shell --command ipython"
alias gg='git log --graph --oneline --date-order'
alias ns='nix-shell --command zsh'
alias cd-clipboard='cd "$(dirname "$(wl-paste)")"'

eval `dircolors ~/.dircolors`

function nvm-use () {
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm use --delete-prefix v1.9.0 node
}

if [ -e ~/.nix-profile/bin/ghc ]; then
  export NIX_GHC="$HOME/.nix-profile/bin/ghc"
  export NIX_GHCPKG="$HOME/.nix-profile/bin/ghc-pkg"
  export NIX_GHC_DOCDIR="$HOME/.nix-profile/share/doc/ghc/html"
  export NIX_GHC_LIBDIR="$HOME/.nix-profile/lib/ghc-$($NIX_GHC --numeric-version)"
fi

#alias heroku=/home/stefan/node_modules/heroku-cli/bin/run
alias ns="nix-shell --command zsh"

export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
# alias vim="emacsclient -t"
alias nvim-session="MAIN_EDITOR=1 nvim"
alias update-askby="ask-update-sources branch askby_py ~/repos/apkgs/sources.json && git add sources.json && ask-commit-sources"

alias jan-lpr="lpr -H 192.168.0.106 -P Brother_DCP-9022CDW"
alias grab="import png:- | xclip -selection c -t image/png"
#
# Get into a shell to run openstack commands
# alias oscsh='docker run -ti --rm -v /home/stefan/.local/share/openstack-cli-data:/data --env-file ${RC_ENV_FILE:-~/.config/osc_rc.env} jmcvea/openstack-client'
# Make it look like you're running openstack locally
# alias openstack='oscsh openstack'

alias ipython='python3 -m IPython'
alias ns='nix-shell --run $SHELL'


c() {
  local dir
  dir=$(find ${1:-~/} -path '*/\.*' -prune \
                  -o -type d -maxdepth 5 -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

csvjson() {
    cat "$1" | tail -n 3 | head -n 1 | cut -f${2:-1} | jq
}


#export PATH=~/.npm-global-stefan/bin/:~/.bin:$PATH


export PRINTER=Drucker2

# export LC_CTYPE=en_US.UTF-8

# c() {
#     cdf ~/
# }
alias av='aws-vault --backend file'
# source $(fzf-share)/key-bindings.zsh

alias isodate='date +%Y-%m-%d'

alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; print (ul.quote_plus(sys.argv[1]))"'

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/stefan/repos/mythology-api/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/stefan/repos/mythology-api/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/stefan/repos/mythology-api/node_modules/tabtab/.completions/sls.zsh ]] && . /home/stefan/repos/mythology-api/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /home/stefan/repos/mythology-api/node_modules/tabtab/.completions/slss.zsh ]] && . /home/stefan/repos/mythology-api/node_modules/tabtab/.completions/slss.zsh
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# direnv
eval "$(direnv hook zsh)"

if [ -x "$(command -v kubectl)" ]; then
    source <(kubectl completion zsh)
fi


function agwire () {
    ag $@ \
    $HOME/repos/cailleach \
    $HOME/repos/wire-docs \
    $HOME/repos/wire-server \
    $HOME/repos/wire-server-deploy \
    $HOME/repos/wire-server-private \
}

function withDir () {
    savedir=$PWD
    cd "$1" || return 1;
    argv=( "$@" )
    eval "${argv[@]:2}";
    cd $savedir
}

alias uuid4="cat /proc/sys/kernel/random/uuid"
alias open-pr="gh pr view --web"
alias vim=nvim

termtitle() { printf "\033]0;$*\007"; }

directory_stack=~/.directory_stack

gpushd() {
    echo $(pwd) >> $directory_stack
}

gpopd() {
    [ ! -s $directory_stack ] && return
    newdir=$(sed -n '$p' $directory_stack)
    sed -i -e '$d' $directory_stack
    cd $newdir
}


if [ "$(hostname)" = "air" ]; then
   if [ -e /Users/stefan/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/stefan/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
fi

alias todoist="todoist --indent --color"
alias tgtd="todo l -f '#CS & #GTD'"

if [ -f ~/.secrets ]; then
    source ~/.secrets
fi

umask 077
ulimit -n 10000

export ws="/home/stefan/repos/wire-server"
export cl="/home/stefan/repos/cailleach"

function fetchCert() {
    openssl s_client -servername "$1" -connect "$1":443 2>&1 | openssl x509 -inform pem -text
}

bindkey '^r' zaw-history
alias tf=terraform
