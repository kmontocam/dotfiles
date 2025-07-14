
export DOCKER_DEFAULT_PLATFORM=linux/amd64

export EDITOR="nvim"

export FZF_CTRL_T_COMMAND="fd . $HOME --type d -H -L -d 3 2> /dev/null"
export FZF_CTRL_T_OPTS="--preview 'tree -C {} | head -128'"
export FZF_DEFAULT_COMMAND='fd . --type d -H -L -d 3 2> /dev/null'
export FZF_DEFAULT_OPTS='--tmux'

export HOMEBREW_NO_EMOJI=1

export JUPYTER_CONFIG_DIR="$HOME/.config/jupyter"
export JUPYTER_DATA_DIR="$HOME/.local/share/jupyter/data"
export JUPYTER_RUNTIME_DIR="$HOME/.local/share/jupyter/runtime"

export K9S_CONFIG_DIR="$HOME/.config/k9s"

export LANG="en_US.UTF-8"

export PATH="$PATH:$HOME/.local/bin"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export TERM="screen-256color"
export TLDR_AUTO_UPDATE_DISABLED=1

export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"

export PNPM_HOME="$HOME/.pnpm"
export PATH="$PNPM_HOME:$PATH"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
