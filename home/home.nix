{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    inputs.xremap-flake.homeManagerModules.default
    inputs.nix-colors.homeManagerModules.default

    ./features/alacritty # requires nixGL on non-nixos
    ./features/dunst
    ./features/emacs
    ./features/file
    ./features/firefox
    ./features/hyprland
    # ./features/kitty # requires nixGL on non-nixos
    ./features/gtk
    # ./features/mako
    # ./features/qutebrowser
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
  targets.genericLinux.enable = true; # Enable this on non nixos

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
      pkgs.gum
      pkgs.mermaid-cli
      pkgs.w3m
      pkgs.ripgrep
      pkgs.entr
      # TODO Check if installed / move to right place
      pkgs.docker
      pkgs.ncdu
      pkgs.newsboat
      pkgs.nsxiv
      pkgs.numlockx
      # pkgs.flatpak # dosent work that well on non-nixos

      pkgs.flameshot
      pkgs.galculator
      pkgs.gparted
      pkgs.kdeconnect
      pkgs.kleopatra
      # pkgs.miniconda
      pkgs.pavucontrol
      pkgs.piper
      # pkgs.r2modman
      pkgs.scrcpy
      pkgs.vlc

      # System management
      pkgs.htop
      pkgs.btop

      pkgs.wallust # better pywal

      pkgs.buku # browser indepenent bookmarks
      pkgs.bukubrow

      pkgs.amdvlk
      pkgs.mesa
      # pkgs.linuxKernel.packages.linux_zen.amdgpu-pro
      pkgs.egl-wayland
      pkgs.i3lock
      pkgs.xss-lock
      pkgs.mcfly
      pkgs.shfmt
      # TODO write qtile conf from hm. use pkgs.go-sct/bin/sct
      pkgs.go-sct
      # pkgs.caffeine

      # Core Packages
      pkgs.libglvnd
      pkgs.mesa.drivers
      pkgs.killall
      pkgs.zip
      pkgs.unzip
      pkgs.light
      pkgs.thunderbird
      pkgs.yt-dlp
      pkgs.keepassxc
      pkgs.pass
      pkgs.libreoffice
      # pkgs.librewolf
      # pkgs.icecat
      pkgs.gpodder
      pkgs.gparted
      pkgs.yt-dlp
      pkgs.tor-browser-bundle-bin
      pkgs.rsync
      pkgs.grsync
      pkgs.feh
      pkgs.htop
      pkgs.wget
      pkgs.gnupg
      pkgs.trash-cli
      pkgs.ncdu # disk space management

      pkgs.rclone
      pkgs.rclone-browser

      # TODO: Move into a flake in required folders
      (pkgs.python310.withPackages(ps: with ps; [ types-beautifulsoup4 beautifulsoup4 requests black pyside6 pylint pillow pywlroots pyflakes poetry-core ]))

      #pkgs.virt-manager
      #pkgs.libvirt
      #pkgs.libvirt-glib
      pkgs.quickemu
      pkgs.quickgui

      pkgs.obs-studio

      #pkgs.godot
      pkgs.aseprite
      pkgs.godot_4
      # pkgs.unityhub
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

      pkgs.syncthing
      pkgs.syncthing-tray

      pkgs.gpodder
      pkgs.ani-cli
      pkgs.mangal
      #pkgs.tachidesk

      # pkgs.discord
      pkgs.betterdiscordctl
      pkgs.signal-desktop
      # pkgs.zoom-us
      # pkgs.slack

      pkgs.cava

      # pkgs.jetbrains.idea-ultimate
      pkgs.jetbrains.idea-community
      pkgs.jetbrains.clion
      # pkgs.jetbrains.rustrover
      pkgs.vscode
      pkgs.android-studio

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

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
  services.syncthing.tray.enable = true;

  services.home-manager.autoUpgrade.frequency = "weekly";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
