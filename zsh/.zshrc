[[ $- =~ i ]] && bindkey -M viins -r '\ec'
[[ $- =~ i ]] && bindkey -M vicmd -r '\ec'
[[ $- =~ i ]] && bindkey -M viins '\ef' fzf-cd-widget
[[ $- =~ i ]] && bindkey -M vicmd '\ef' fzf-cd-widget

set -o vi
setopt AUTO_CD

alias cd="z"
alias cl="clear"
alias drs="sudo darwin-rebuild switch --flake $HOME/git/dotfiles/nix-darwin#kmontocam --impure"
alias g="git"
alias hms="home-manager switch --impure"
alias ipy="ipython --TerminalInteractiveShell.editing_mode=vi --TerminalInteractiveShell.emacs_bindings_in_vi_insert_mode=False"
alias kb="kubebuilder"
alias ku="kubectl"
alias ldo="lazydocker"
alias lg="lazygit"
alias lvenv="source ./.venv/bin/activate"
alias myip="curl http://ifconfig.io"
alias nfu="nix flake update --flake $HOME/git/dotfiles/nix-darwin"
alias nv="nvim"
alias tf="terraform"
alias tg="terragrunt"
alias vi="nvim"
alias vim="nvim"
alias zshsource="source ~/.zshrc"

set_jupyter_venv() {
    if ! uv pip install ipykernel; then
        return 1
    fi
    uv run python -m ipykernel install --sys-prefix
    export JUPYTER_PATH="$PATH:$(pwd)/.venv/share/jupyter"
}

alias jvenv=set_jupyter_venv

# yank/cut to the system clipboard
bindkey -v
function vi-yank-xclip {
    zle vi-yank
    echo "$CUTBUFFER" | pbcopy -i
}
function vi-yank-cut-xclip {
    zle vi-yank
    echo "$CUTBUFFER" | pbcopy
    zle kill-whole-line
}

zle -N vi-yank-xclip
zle -N vi-yank-cut-xclip

bindkey -M vicmd ' y' vi-yank-xclip
bindkey -M vicmd ' d' vi-yank-cut-xclip

source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
