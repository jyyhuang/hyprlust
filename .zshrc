# colorscheme
(cat ~/.cache/wallust/sequences &)

# plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# load modules
autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME/zcompdump"
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

# cmp opts
zstyle ':completion:*' menu select # tab opens cmp menu
zstyle ':completion:*' special-dirs true # force . and .. to show
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # colorize
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case insensitive

# variables
typeset -U path PATH
path=(
    "$XDG_CONFIG_HOME/scripts"
    "$HOME/.local/bin"
    $path
)

export NVM_DIR="$HOME/.nvm"
export LESS='-R --use-color -Dd+r$Du+b$'
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export BAT_THEME="base16"

export FZF_DEFAULT_OPTS="--layout=reverse --bind=tab:down,shift-tab:up --border --preview='bat -p --color=always {}'"
export FZF_CTRL_R_OPTS="--style minimal --info inline --bind=tab:down,shift-tab:up --border --no-sort --no-preview"

# history opts
HISTFILE="$XDG_CACHE_HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# opts
setopt append_history share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_expire_dups_first
setopt hist_find_no_dups

setopt menu_complete # autocmp first menu match
setopt autocd # type a dir to cd
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt globdots # include dotfiles
setopt extended_glob
setopt interactive_comments # allow comments in shell
unsetopt prompt_sp
setopt noclobber
setopt nobeep

# alias
alias v="nvim"
alias ll="ls -la"
alias cat="bat"
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -c=auto'

# binds
# bind Ctrl+F to fzf file, open in nvim, and cd to directory
function _fzf_open_nvim() {
    local file
    file=$(find . -type f | fzf --no-preview) || return

    local dir=${file:h}

    nvim "$file"

    if [[ -d "$dir" ]]; then
        cd "$dir"
        zle reset-prompt
    fi
}
zle -N _fzf_open_nvim
bindkey '^F' _fzf_open_nvim

# yazi wrapper
function z() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

# up or down in history with search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# setup programs
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
