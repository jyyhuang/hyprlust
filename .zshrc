# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
(cat ~/.cache/wallust/sequences &)

# Paths
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:$PATH"

# Add default node to path
export PATH=~/.nvm/versions/node/v12.16.1/bin:$PATH

# Load NVM
export NVM_DIR=~/.nvm
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

autoload -Uz compinit promptinit
compinit
promptinit

bindkey -v

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
unsetopt beep

function z() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias v="nvim"
alias ll="ls -la"
alias cat="bat"

#Colors
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
export LESS='-R --use-color -Dd+r$Du+b$'
alias ls='ls --color=auto'
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"

export FZF_DEFAULT_OPTS="--layout=reverse --bind=tab:down,shift-tab:up"
source <(fzf --zsh)

bindkey '^I' autosuggest-accept

# Bind Ctrl+F to the desired command
# Bind Ctrl+F (represented as "^F") to call the fzf_open function
bindkey -s '^F' 'file=$(find . | fzf --preview "bat --style=numbers --color=always {}") && nvim "$file" && cd $(dirname "$file")\n'

export ZSH_AUTOSUGGEST_STRATEGY=(
    history
    completion
)

export EDITOR="nvim"
export VISUAL="$EDITOR"
export BAT_THEME="base16"
eval "$(zoxide init --cmd cd zsh)"
if [[ -z "${SSH_CONNECTION}" ]]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

eval "$(starship init zsh)"
