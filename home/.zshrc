# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export LC_ALL="en_US.UTF-8"

export PATH=~/bin:/usr/local/sbin:$PATH:$HOME/.rvm/bin:/Library/TeX/texbin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Kiex Elixir version manager: https://github.com/taylor/kiex
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

alias v="gvim ."

alias gits="git status"
alias gitlines="git log --oneline --all | wc -l"
alias gpr="hub pull-request -b develop"
alias git-clean-branches="git branch --merged | grep -v \"\*\" | grep -v master | grep -v dev | xargs -n 1 git branch -d"

alias ssh-config="mvim ~/.ssh/config"
alias zsh-config="mvim ~/.zshrc"
alias git-config="mvim ~/.gitconfig"
alias vim-config="mvim ~/.vimrc.local"
alias vim-bundles="mvim ~/.vimrc.bundles.local"
alias ledger-config="mvim ~/.ledgerrc"

# docker
alias dc="docker-compose"
alias dcr="docker-compose run"
alias dclf="dc logs -f --tail=100"

alias devlog="tail -f log/development.log"
alias testlog="tail -f log/test.log"

alias reload!="source ~/.zshrc"

# From the "Vendor everything" blog post
alias b="bundle"
alias bi="b install --path vendor"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

alias wuk="xxd -l 3 -p /dev/random | tee >(xargs wasko -p) >(cowsay)"

alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"

# Log all the things
# https://spin.atomicobject.com/2016/05/28/log-bash-history/
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(fc -ln -1)" >> ~/.logs/zsh-history-$(date "+%Y-%m-%d").log; fi'
precmd() { eval "$PROMPT_COMMAND" }

wa () {
  color=$(random_css_color)
  wasko -p $color
  echo "O HAI $color:u"
}

teste () {
  set -x
  be rake db:test:prepare
  be rspec
}

# Copy GitHub public key to clipboard
ghkey () {
    if (( $# < 1 ))
    then
        echo "usage: ghkey <username>"
        return 1
    fi
    curl -sL https://github.com/$1.keys | pbcopy
}

function ruboload() {
    curl -Lo ~/.rubocop.yml https://raw.githubusercontent.com/Reprazent/hound/master/config/style_guides/ruby.yml
}

function git_current_branch() {
  local info
  if test -z $(git rev-parse --git-dir 2> /dev/null); then
    info=''
  else
    info="${$(git symbolic-ref HEAD 2> /dev/null)#refs/heads/}"
  fi
  echo -n "$info"
}

function migration_touch() {
  if [ $# != 1 ]
  then
    echo "usage: migration_touch <filepath>"
    return 1
  fi

  new_timestamp=$(date "+%Y%m%d%H%M%S")
  new_filename=$(echo $1 | sed -e "s/[0-9]\{14\}/$new_timestamp/")
  echo "\033[1mTouch\033[0m $new_filename"
  mv -v $1 $new_filename
}

function top_commands() {
  history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}

function git-stashes() {
  git stash list | awk -F: '{ print "\n\n\n\n"; print $0; print "\n\n"; system("git -c color.ui=always stash show -p " $1); }' | less -R
}

function stats() {
    fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep --color=auto -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}

# Ibanity functions
function dashboard-npm-install() {
  docker-compose stop dashboard
  rm -v dashboard/package-lock.json
  echo -n "Removing node_modules... "
  sudo rm -rf dashboard/node_modules
  echo "\033[1mDone\033[0m"
  mkdir dashboard/node_modules
  sudo chown ibanity dashboard/node_modules
  docker-compose run --rm dashboard npm install
  docker-compose start dashboard
}

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"

# Powerlevel9k config: https://github.com/bhilburn/powerlevel9k
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs rvm time)
POWERLEVEL9K_RVM_VISUAL_IDENTIFIER_COLOR="red"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

DEFAULT_USER='periplo'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/bram/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/bram/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/bram/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/bram/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

