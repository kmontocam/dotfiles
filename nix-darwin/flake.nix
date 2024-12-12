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
	  pkgs.azure-cli
	  pkgs.exiftool
	  pkgs.fd
	  pkgs.fzf
	  pkgs.go
	  pkgs.grpc
	  pkgs.grpcui
	  pkgs.grpcurl
	  pkgs.home-manager
	  pkgs.jq
	  pkgs.k9s
	  pkgs.kubectl
	  pkgs.kubernetes-helm
	  pkgs.jdk17
	  pkgs.krew
	  pkgs.mas
	  pkgs.mkalias
	  pkgs.neovim
	  pkgs.nerd-fonts.jetbrains-mono
	  pkgs.nmap
	  pkgs.nodejs_22
	  pkgs.lazygit
	  pkgs.lazydocker
	  pkgs.tcptraceroute
	  pkgs.terraform
	  pkgs.terragrunt
	  pkgs.typescript
	  pkgs.ripgrep
	  pkgs.rustup
	  pkgs.silicon
	  pkgs.starship
	  pkgs.tmux
	  pkgs.tldr
	  pkgs.uv
	  pkgs.wget
	  pkgs.zoxide
        ];

      homebrew = {
        enable = true;
	casks = [
	  "arc"
	  "balenaetcher"
	  "chatgpt"
	  "discord"
	  "docker"
	  "iterm2"
	  "logi-options+"
	  "mongodb-compass"
	  "notion"
	  "setapp"
	  "slack"
	  "soundsource"
	  "spotify"
	  "rectangle"
	  "raspberry-pi-imager"
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
	  "/Applications/iTerm.app"
	];
	dock.wvous-bl-corner = 1;
	dock.wvous-br-corner = 1;
	finder.AppleShowAllExtensions = true;
	# TODO: define and move to only clipboard or directly trash
	# screencapture.location =
	# minimum, decrease in UI 
	NSGlobalDomain.InitialKeyRepeat = 15;
	NSGlobalDomain.KeyRepeat = 2;
	".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;

	# NOTE: configuration causes error
	# universalaccess.reduceMotion = true;

	# manual wallpaper setup
	# manual creation of Desktops with Keyboard Shortcuts
	#   Keyboard > Keyboard Shortcuts > Mission Control > Mission Control
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
