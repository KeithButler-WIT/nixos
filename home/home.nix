{ config, lib, pkgs, inputs, userSettings, ... }:

{

  imports = [
    inputs.nix-colors.homeManagerModules.default
    # inputs.nixvim.homeManagerModules.nixvim
    ./features
  ];

  #nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
    permittedInsecurePackages = [
      "openssl-1.1.1u"
      "python-2.7.18.6"
      "nodejs-16.20.1"
      "nodejs-16.20.2"
    ];
  };

  #targets.genericLinux.enable = true; # Enable this on non nixos

  nix = {
    # package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ userSettings.username ];
      extra-substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
      ];
      extra-trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      # substituters = [ "https://cache.nixos.org" "https://tomodachi94.cachix.org" ];
      # trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "tomodachi94.cachix.org-1:E1WFk+SYPtq3FFO+NvDgsyciIHg8nHxB/z7qNfojxpI=" ];
    };
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";
  home = {
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      # TODO add to direnv in required projects

      nixpkgs-fmt
      shfmt

      egl-wayland
      # pkgs.python311
      (python311.withPackages (ps: with ps; [ types-beautifulsoup4 beautifulsoup4 ]))

      toybox

      # TODO: Move into a flake in required folders
      # (pkgs.python310.withPackages (ps: with ps; [ pytz numpy types-beautifulsoup4 beautifulsoup4 requests black pyside6 pylint pillow pywlroots pyflakes poetry-core ]))

      fira-code-symbols
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "SourceCodePro" "FantasqueSansMono" "FiraCode" "OpenDyslexic" "JetBrainsMono" "Hack" ]; })
      corefonts
      noto-fonts

      v4l-utils

      termusic

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];
  };

  lf.enable = true;

  programs.java.enable = true;

  # services.mpd = {
  #   enable = true;
  #   musicDirectory = "~/Music";
  # };

  services.syncthing.enable = true;
  # services.syncthing.tray.enable = true;

  services.home-manager.autoUpgrade.frequency = "monthly";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
