# activate homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# ignore beer emoji pouring brew packaged
export HOMEBREW_NO_EMOJI=1

export TLDR_AUTO_UPDATE_DISABLED=1

# default editor in k9s
export EDITOR="nvim"
export K9S_CONFIG_DIR="$HOME/.config/k9s"

# Created by `pipx` on 2023-11-06 01:22:11
export PATH="$PATH:$HOME/.local/bin"
export LANG="en_US.UTF-8"
export DOCKER_DEFAULT_PLATFORM=linux/amd64
