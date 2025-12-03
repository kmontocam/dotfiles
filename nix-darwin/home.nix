{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kmontocam";
  home.homeDirectory = "/Users/kmontocam";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # ()

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/ghostty".source = "${config.home.homeDirectory}/git/dotfiles/ghostty";
    ".config/k9s/config.yaml".source = "${config.home.homeDirectory}/git/dotfiles/k9s/config.yaml";
    ".config/k9s/skins/transparent.yaml".source = "${config.home.homeDirectory}/git/dotfiles/k9s/skins/transparent.yaml";
    ".config/nvim".source = "${config.home.homeDirectory}/git/dotfiles/nvim";
    ".config/opencode/opencode.json".source = "${config.home.homeDirectory}/git/dotfiles/opencode/opencode.json";
    ".config/starship.toml".source = "${config.home.homeDirectory}/git/dotfiles/starship/starship.toml";
    ".fdignore".source = "${config.home.homeDirectory}/git/dotfiles/.fdignore";
    ".gitconfig".source = "${config.home.homeDirectory}/git/dotfiles/.gitconfig";
    ".gitignore_global".source = "${config.home.homeDirectory}/git/dotfiles/.gitignore_global";
    ".hammerspoon/init.lua".source = "${config.home.homeDirectory}/git/dotfiles/hammerspoon/init.lua";
    ".ipython/profile_default/ipython_config.py".source = "${config.home.homeDirectory}/git/dotfiles/ipython/profile_default/ipython_config.py";
    ".tmux.conf".source = "${config.home.homeDirectory}/git/dotfiles/tmux/.tmux.conf";
    ".tool-versions".source = "${config.home.homeDirectory}/git/dotfiles/.tool-versions";
    "Library/Application Support/euporie".source = "${config.home.homeDirectory}/git/dotfiles/euporie";
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kmontocam/etc/profile.d/hm-session-vars.sh
  #
home.sessionVariables = {
    DOCKER_DEFAULT_PLATFORM = "linux/amd64";
    EDITOR = "nvim";
    HOMEBREW_NO_EMOJI = "1";
    JUPYTER_CONFIG_DIR = "$HOME/.config/jupyter";
    JUPYTER_DATA_DIR = "$HOME/.local/share/jupyter/data";
    JUPYTER_RUNTIME_DIR = "$HOME/.local/share/jupyter/runtime";
    K9S_CONFIG_DIR = "$HOME/.config/k9s";
    LANG = "en_US.UTF-8";
    PNPM_HOME = "$HOME/.pnpm";
    TLDR_AUTO_UPDATE_DISABLED = "1";
    VISUAL = "nvim";
    WASMTIME_HOME = "$HOME/.wasmtime";
  };

home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
    "$HOME/.asdf/shims"
    "$HOME/.krew/bin"
    "$HOME/.local/bin"
    "$HOME/.pnpm"
    "$HOME/.wasmtime/bin"
    "$HOME/.bun/bin"
    "/opt/homebrew/opt/libpq/bin"
  ];

  # install/update tools with programming language package managers during activation
  home.activation = {
    installUvTools = lib.hm.dag.entryAfter ["writeBoundary"] ''
      export PATH="$HOME/.local/bin:$PATH"
      $DRY_RUN_CMD ${pkgs.uv}/bin/uv tool install --upgrade alembic
      $DRY_RUN_CMD ${pkgs.uv}/bin/uv tool install --upgrade euporie
      $DRY_RUN_CMD ${pkgs.uv}/bin/uv tool install --upgrade grip
      $DRY_RUN_CMD ${pkgs.uv}/bin/uv tool install --upgrade ipython
      $DRY_RUN_CMD ${pkgs.uv}/bin/uv tool install --upgrade nbconvert
    '';

    installBunTools = lib.hm.dag.entryAfter ["writeBoundary"] ''
      export PATH="$HOME/.bun/bin:$PATH"
      $DRY_RUN_CMD ${pkgs.bun}/bin/bun install -g @modelcontextprotocol/inspector
      $DRY_RUN_CMD ${pkgs.bun}/bin/bun install -g opencode-ai@latest
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.fzf = {
    enable = true;
    defaultCommand = "fd . --type d -H -L -d 3 2> /dev/null";
    fileWidgetCommand = "fd . $HOME --type d -H -L -d 3 2> /dev/null";
    fileWidgetOptions = [
      "--preview 'tree -C {} | head -128'"
    ];
    defaultOptions = [ "--tmux" ];
  };
  programs.zsh = {
   autosuggestion = {
      enable = true;
      highlight = "fg=#666666";
    }; enable = true;
    autocd = true;
    defaultKeymap = "viins";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      cd = "z";
      cl = "clear";
      drs = "sudo darwin-rebuild switch --flake $HOME/git/dotfiles/nix-darwin#kmontocam --impure";
      g = "git";
      ipy = "ipython";
      jvenv = "set_jupyter_venv";
      kb = "kubebuilder";
      ku = "kubectl";
      ldo = "lazydocker";
      lg = "lazygit";
      lvenv = "source ./.venv/bin/activate";
      myip = "curl http://ifconfig.io";
      nfu = "nix flake update --flake $HOME/git/dotfiles/nix-darwin";
      nv = "nvim";
      tf = "terraform";
      tg = "terragrunt";
      vi = "nvim";
      vim = "nvim";
      zshsource = "source ~/.zshrc";
    };

    setOptions = [
      "AUTO_CD"
    ];

    initContent = ''

      # jupyter venv function
      set_jupyter_venv() {
          if ! uv pip install ipykernel; then
              return 1
          fi
          uv run python -m ipykernel install --sys-prefix
          export JUPYTER_PATH="$PATH:$(pwd)/.venv/share/jupyter"
      }

      # yank/cut to system clipboard
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

      # source external tools
      source <(fzf --zsh)
      eval "$(zoxide init zsh)"
      eval "$(starship init zsh)"

      # disable esc cd widget default keybinds in fzf, replace with ctrl+p
      bindkey -M viins -r '\ec'
      bindkey -M vicmd -r '\ec'
      bindkey '^P' fzf-cd-widget
    '';
  };
  # using both `tmux.conf` and home-manager config
  # keeping plugin management in home-manager and required configs to prevent conflicts
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    historyLimit = 65536;
    keyMode = "vi";
    mouse = true;
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
      pkgs.tmuxPlugins.resurrect
      {
        plugin = pkgs.tmuxPlugins.mkTmuxPlugin {
          pluginName = "tmux-power";
          rtpFilePath = "tmux-power.tmux";
          version = "stable-2024-11-30";
          src = pkgs.fetchFromGitHub {
            owner = "wfxr";
            repo = "tmux-power";
            rev = "master";
            sha256 = "sha256-IyYQyIONMnVBwhhcI3anOPxKpv2TfI2KZgJ5o5JtZ8I=";
          };
        };
        extraConfig = ''
          set -g @tmux_power_theme '#CCCCCC'
        '';
      }
    ];
    resizeAmount = 5;
  };
}
