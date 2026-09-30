set -g fish_greeting

fish_add_path -g ~/.local/bin

set -gx EDITOR vim

set -gx ANDROID_HOME $HOME/Android/Sdk
# JAVA_HOME is set by mise once a Java is active, e.g. `mise use -g java@temurin-8`

# pnpm
set -gx PNPM_HOME $HOME/.local/share/pnpm
test -d $PNPM_HOME; and fish_add_path -g $PNPM_HOME

# Log all the things
# https://spin.atomicobject.com/2016/05/28/log-bash-history/
function __log_history --on-event fish_postexec
    fish_is_root_user; and return
    string length -q -- $argv[1]; or return
    mkdir -p ~/.logs
    echo (date "+%Y-%m-%d.%H:%M:%S") $PWD $argv[1] >>~/.logs/fish-history-(date "+%Y-%m-%d").log
end

if status is-interactive
    # Replaces nvm, pyenv, pyenv-virtualenv and rvm
    type -q mise; and mise activate fish | source
    type -q starship; and starship init fish | source
    type -q zoxide; and zoxide init fish | source
    # Ctrl-R history, Ctrl-T files, Alt-C directories
    type -q fzf; and fzf --fish | source

    # Carried over from the oh-my-zsh git plugin
    abbr -a g git
    abbr -a gc git commit --verbose
    abbr -a gco git checkout
    abbr -a gd git diff
    abbr -a glog git log --oneline --decorate --graph

    abbr -a gits git status

    # docker
    abbr -a dc docker compose
    abbr -a dcr docker compose run
    abbr -a dclf docker compose logs -f --tail=100

    abbr -a reload! exec fish

    alias pbcopy wl-copy
    alias pbpaste "wl-paste --no-newline"
end
