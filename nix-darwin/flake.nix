{
  description = "kmontocam nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
	  pkgs.awscli2
	  pkgs.azure-cli
	  pkgs.bat
	  pkgs.exiftool
	  pkgs.fd
	  pkgs.fzf
	  pkgs.gitleaks
	  pkgs.go
	  pkgs.grpc
	  pkgs.grpcui
	  pkgs.grpcurl
	  pkgs.home-manager
	  pkgs.jdk17
	  pkgs.jq
	  pkgs.jwt-cli
	  pkgs.k9s
	  pkgs.krew
	  pkgs.kubebuilder
	  pkgs.kubectl
	  pkgs.kubernetes-helm
	  pkgs.lazydocker
	  pkgs.lazygit
	  pkgs.mas
	  pkgs.mdbook
	  pkgs.mkalias
	  pkgs.mongosh
	  pkgs.neovim
	  pkgs.nerd-fonts.jetbrains-mono
	  pkgs.nmap
	  pkgs.nodejs_22
	  pkgs.openssl
	  pkgs.pandoc
	  pkgs.ripgrep
	  pkgs.rustup
	  pkgs.silicon
	  pkgs.starship
	  pkgs.tcptraceroute
	  pkgs.tectonic
	  pkgs.terraform
	  pkgs.terragrunt
	  pkgs.tldr
	  pkgs.tmux
	  pkgs.tshark
	  pkgs.tree
	  pkgs.tree-sitter
	  pkgs.typescript
	  pkgs.uv
	  pkgs.wget
	  pkgs.yq-go
	  pkgs.zoxide
        ];

      homebrew = {
        enable = true;
	brews = [
	  "libpq"  # includes psql
	];
	casks = [
	  "arc"
	  "balenaetcher"
	  "chatgpt"
	  "discord"
	  "docker"
	  "ghostty"
	  "hammerspoon"
	  "logi-options+"
	  "mongodb-compass"
	  "notion"
	  "raspberry-pi-imager"
	  "rectangle"
	  "setapp"
	  "slack"
	  "soundsource"
	  "spotify"
	  "utm"
	  "zoom"
	];
	masApps = {
	  "Final Cut Pro" = 424389933;
	  "Pixelmator Pro" = 1289583905;
	  "WhatsApp" = 310633997; 
	};
	onActivation.cleanup = "zap";
	onActivation.autoUpdate = true;
	onActivation.upgrade = true;
      };
      
      fonts.packages = [
      	pkgs.nerd-fonts.jetbrains-mono
      ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      system.activationScripts.extraActivation.text = ''
	softwareupdate --install-rosetta --agree-to-license
      '';

      system.defaults = {
      	dock.persistent-apps = [
	  "/Applications/Safari.app"
	  "/System/Applications/Mail.app"
	  "/System/Applications/Calendar.app"
	  "/System/Applications/System Settings.app"
	  "/Applications/Notion.app"
	  "/Applications/Ghostty.app"
	];
	dock.wvous-bl-corner = 1;
	dock.wvous-br-corner = 1;
	dock.autohide = true;
	finder.AppleShowAllExtensions = true;
	# minimum, decrease in UI 
	NSGlobalDomain.InitialKeyRepeat = 15;
	NSGlobalDomain.KeyRepeat = 2;
	".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;

	# NOTE: configuration causes error
	# universalaccess.reduceMotion = true;

	# manual wallpaper setup
	# manual creation of Desktops with Keyboard Shortcuts:
	#   Keyboard > Keyboard Shortcuts > Mission Control > Mission Control
	#   Desktop & Dock -> Mission Control -> Automatically rearrange spaced based on most recent activity (disable)
	# Screenshot.app -> Options -> Save To -> Clipboard
      };

      security.pam.enableSudoTouchIdAuth = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      users.users.kmontocam.home = "/Users/kmontocam";
      nix.configureBuildUsers = true;
      nix.useDaemon = true;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."kmontocam" = nix-darwin.lib.darwinSystem {
      modules = [
      	configuration
	home-manager.darwinModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.kmontocam = import ./home.nix;
	}
	nix-homebrew.darwinModules.nix-homebrew {
	  nix-homebrew = {
	    enable = true;
	    enableRosetta = true;
	    user = "kmontocam";
	  };
	}
      ];
    };
  };
}
