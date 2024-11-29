source <(fzf --zsh)

export FZF_DEFAULT_COMMAND='fd . --type d -H -L -d 3 2> /dev/null'
export FZF_DEFAULT_OPTS='--tmux'
export FZF_CTRL_T_COMMAND="fd . $HOME --type d -H -L -d 3 2> /dev/null"
export FZF_CTRL_T_OPTS="--preview 'tree -C {} | head -128'"

[[ $- =~ i ]] && bindkey -M viins -r '\ec'
[[ $- =~ i ]] && bindkey -M vicmd -r '\ec'
[[ $- =~ i ]] && bindkey -M viins '\ef' fzf-cd-widget
[[ $- =~ i ]] && bindkey -M vicmd '\ef' fzf-cd-widget

# opts
set -o vi
setopt AUTO_CD

# custom aliases
alias zshconf="nvim ~/.zshrc"
alias zshsource="source ~/.zshrc"
alias cd="z"
alias cl="clear"
alias vi="nvim"
alias vim="nvim"
alias nv="nvim"
alias lg="lazygit"
alias ldo="lazydocker"
alias ipy="ipython"
alias tf="terraform"
alias tg="terragrunt"
alias lvenv="source ./.venv/bin/activate"
alias ku="kubectl"
alias myip="curl http://ifconfig.io"

# yank to the system clipboard
bindkey -v
function vi-yank-xclip {
    zle vi-yank
    echo "$CUTBUFFER" | pbcopy -i
}

zle -N vi-yank-xclip
bindkey -M vicmd ' y' vi-yank-xclip

# TODO: bind ' d' to delete inline with copy

eval "$(zoxide init zsh)"

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
