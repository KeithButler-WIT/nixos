{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    inputs.nix-colors.homeManagerModules.default
    # inputs.nixvim.homeManagerModules.nixvim

    ./features/gui
    ./features/tui
    ./features/file
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
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # colorScheme = inputs.nix-colors.colorSchemes.onedark;
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  # colorScheme = inputs.nix-colors.colorSchemes.dracula;
  # colorScheme = inputs.nix-colors.colorSchemes.nord;
  # colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  # colorScheme = inputs.nix-colors.colorSchemes.solarized;
  # colorScheme = inputs.nix-colors.colorSchemes.tango;
  # colorScheme = inputs.nix-colors.colorSchemes.nova;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "keith";
  home.homeDirectory = "/home/keith";
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
    packages = [
      # TODO add to direnv in required projects

      pkgs.nixpkgs-fmt
      pkgs.shfmt

      #pkgs.egl-wayland
      #pkgs.xss-lock # X i3lock

      # TODO: Move into a flake in required folders
      (pkgs.python310.withPackages (ps: with ps; [ pytz numpy types-beautifulsoup4 beautifulsoup4 requests black pyside6 pylint pillow pywlroots pyflakes poetry-core ]))

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      #pkgs.fira-code-symbols
      (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "SourceCodePro" "FantasqueSansMono" "FiraCode" "OpenDyslexic" "JetBrainsMono" ]; })
      # pkgs.nerdfonts
      pkgs.corefonts

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];
  };

  programs.java.enable = true;

  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
  };

  services.syncthing.enable = true;
  # services.syncthing.tray.enable = true;

  services.home-manager.autoUpgrade.frequency = "weekly";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
