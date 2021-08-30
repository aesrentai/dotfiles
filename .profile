#character encoding (silences some error messages)
export LC_ALL=en_US.UTF-8

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# add personal bin to PATH
if [ -d "$HOME/bin" ]; then
	export PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

#the best editor
if [ -f /usr/bin/vim ]; then
	export VISUAL=vim 
	export EDITOR=$VISUAL
else
	export VISUAL=nano
	export EDITOR=$VISUAL
fi

#ssh using GPG public key
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

#Universal aliases below
if [ -x /usr/bin/dircolors ]; then
	alias ls="ls --color=auto"
fi
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
