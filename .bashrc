# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi

# enable vi keybindings
set -o vi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

#character encoding (silences some error messages)
export LC_ALL=en_US.UTF-8

# add personal bin to PATH
if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# add go bin to PATH
if [ -d "$HOME/go/bin" ]; then
    export PATH="$HOME/go/bin:$PATH"
fi

# add rust binaries if installed
if [ -f "$HOME/.cargo/env" ]; then
    . $HOME/.cargo/env
fi

# show current working path in shell
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

#the best editor
if [ -f /usr/bin/vim ]; then
    export VISUAL=vim
    export EDITOR=$VISUAL
else
    export VISUAL=vi
    export EDITOR=$VISUAL
fi

# if this is not a ssh session
if command -v gpgconf &> /dev/null && [[ -z "$SSH_CLIENT" && -z "$SSH_CONNECTION" && "$(ps -o comm= -p "$PPID")" != "sshd" ]]; then
    #ssh using GPG public key
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
else
    #allow kitty to play nice with ssh
    export TERM="xterm-256color"
fi


#Universal aliases below
if [ -x /usr/bin/dircolors ]; then
    alias ls="ls --color=auto"
fi
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles_init() {
    # Update all submodules
    dotfiles submodule update --init --recursive

    # make sure vim is ready for YCM
    local VIM_OPTS=$(vim --version | grep +python)
    if [ -n "$VIM_OPTS" ]; then
        # set YCM flags
        local DIR=$(pwd)
        local FLAGS=""
        if [ -f /usr/bin/clang ]; then
            FLAGS="--clangd-completer"
        fi
        if [ -d $HOME/.cargo ]; then
            FLAGS="--rust-completer $FLAGS"
        fi
        if [ -f /usr/bin/go ]; then
            FLAGS="--go-completer $FLAGS"
        fi
        if [ -f /usr/bin/npm ]; then
            FLAGS="--ts-completer $FLAGS"
        fi

        # build YCM
        cd $HOME/.vim/pack/plugins/start/vim-ycm
        python3 install.py $FLAGS
        cd $DIR
    else
        echo "Vim not compiled with python support, cannot build YouCompleteMe"
    fi
}

macos_init() {
    # install homebrew if not installed
    if [ ! -d "/opt/homebrew" ] && [ ! -d "/usr/local/Homebrew" ] && ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install --cask nikitabobko/tap/aerospace
    brew install vim cmake firefox chromium bash flameshot
    if ! grep -q "^/usr/local/bin/bash$" /etc/shells; then
            sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
    fi
    if [ "$(dscl . -read /Users/$USER UserShell | cut -d: -f2)" != "/usr/local/bin/bash" ]; then
            chsh -s /usr/local/bin/bash
    fi
    dotfiles_init
}

if [ "$(uname)" == "Darwin" ]; then
    if [ -f "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    alias firefox="open -a /Applications/Firefox.app"
fi

# Use gvim on Fedora since system clipboard integration is disabled
if [ -f /etc/os-release ]; then
      source /etc/os-release
fi
if [[ $ID -eq "fedora" && -f "/bin/gvim" ]]; then
    alias vim="gvim -v"
fi
