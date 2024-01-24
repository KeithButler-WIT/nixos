{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    inputs.xremap-flake.homeManagerModules.default
    inputs.nix-colors.homeManagerModules.default
    # inputs.nixvim.homeManagerModules.nixvim

    ./features/alacritty # requires nixGL on non-nixos
    ./features/dunst
    ./features/emacs
    ./features/file
    ./features/firefox
    ./features/hyprland
    ./features/kitty # requires nixGL on non-nixos
    ./features/gtk
    # ./features/mako
    ./features/qutebrowser
    ./features/shell
    ./features/steam
    ./features/vm
    # ./features/spicetify # Requires spotify premium
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
      # (pkgs.python3Packages.buildPythonPackage rec {
      #   pname = "rimpy";
      #   version = "1.2.6.29";
      #   src = pkgs.fetchPypi {
      #       inherit pname version;
      #       sha256 = lib.fakeSha256;
      #   };
      #   format = "pyproject";
      #   propagatedBuildInputs = with pkgs; [
      #       python3Packages.setuptools
      #       python3Packages.poetry-core
      #       poetry
      #   ];
      #   doCheck = false;
      #   })

      # (pkgs.stdenv.mkDerivation rec {
      #   name = "rimpy-${version}";
      #   version = "1.2.6.29";

      #   let src = pkgs.fetchFromGitHub {
      #     owner  = "rimpy-custom";
      #     repo   = "rimpy";
      #     rev    = "88150c7b8a0664a70757ffd88b2ac12b84dd0604";
      #     sha256 = "1mb3gfg01mj7ajjl1ylw24mnwamcnnifbxkakzal2j6ibqyqw6rq";
      #   };
      #   in
      #   import nix-build ${src}/release.nix
      pkgs.waybar
      pkgs.swww
      pkgs.r2modman
      pkgs.bottles
      pkgs.corefonts

      # TODO add to direnv in required projects
      pkgs.gum
      pkgs.mermaid-cli
      # TODO Check if installed / move to right place
      pkgs.docker
      pkgs.nsxiv
      pkgs.numlockx

      pkgs.flameshot
      pkgs.galculator
      pkgs.gparted
      pkgs.kdeconnect
      pkgs.kleopatra
      #pkgs.conda
      pkgs.pavucontrol
      pkgs.piper
      # pkgs.r2modman
      pkgs.scrcpy
      #pkgs.vlc

      pkgs.wallust # better pywal

      pkgs.buku # browser indepenent bookmarks
      pkgs.bukubrow

      pkgs.amdvlk
      pkgs.mesa
      pkgs.egl-wayland
      pkgs.xss-lock
      pkgs.mcfly
      pkgs.shfmt

      # Core Packages
      pkgs.libglvnd
      pkgs.mesa.drivers
      pkgs.thunderbird
      pkgs.keepassxc
      pkgs.libreoffice
      # pkgs.librewolf
      # pkgs.icecat
      pkgs.floorp
      pkgs.gpodder
      pkgs.gparted
      pkgs.tor-browser-bundle-bin
      pkgs.rsync
      pkgs.grsync

      pkgs.rclone
      pkgs.rclone-browser

      # TODO: Move into a flake in required folders
      (pkgs.python310.withPackages (ps: with ps; [ types-beautifulsoup4 beautifulsoup4 requests black pyside6 pylint pillow pywlroots pyflakes poetry-core ]))

      pkgs.obs-studio

      pkgs.go-sct

      #pkgs.godot
      pkgs.aseprite
      pkgs.godot_4
      #pkgs.unityhub
      pkgs.blender

      pkgs.mullvad-vpn

      # Xorg
      pkgs.xdg-desktop-portal-gtk
      pkgs.xorg.libX11
      pkgs.xorg.libX11.dev
      pkgs.xorg.libxcb
      pkgs.xorg.libXft
      pkgs.xorg.libXinerama
      pkgs.xorg.xinit
      pkgs.xorg.xinput

      pkgs.gpodder
      pkgs.ani-cli
      pkgs.mangal
      #pkgs.tachidesk

      #pkgs.discord
      pkgs.discord-screenaudio
      pkgs.betterdiscordctl
      pkgs.signal-desktop
      pkgs.zoom-us
      pkgs.slack

      pkgs.cava

      # pkgs.jetbrains.idea-ultimate
      pkgs.jetbrains.idea-community
      pkgs.jetbrains.clion
      pkgs.jetbrains.rust-rover
      pkgs.vscode
      pkgs.android-studio

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      #pkgs.fira-code-symbols
      (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "SourceCodePro" "FantasqueSansMono" "FiraCode" "OpenDyslexic" "JetBrainsMono" ]; })
      # pkgs.nerdfonts
      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    # You can also manage environment variables but you will have to manually
    # source
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/keith/etc/profile.d/hm-session-vars.sh
    #
    # if you don't want to manage your shell through Home Manager.


  };

  # wayland.windowManager.hyprland.enable = true;
  # wayland.windowManager.hyprland.systemdIntegration = true;
  # wayland.windowManager.hyprland.xwayland.enable = true;

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
