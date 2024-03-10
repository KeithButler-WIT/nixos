{ config, lib, pkgs, ... }:

{

  imports = [
    ./alacritty # requires nixGL on non-nixos
    ./discord
    ./dunst
    # ./firefox
    ./hyprland
    ./kitty # requires nixGL on non-nixos
    ./gtk
    # ./mako
    ./mpv
    ./qutebrowser
    ./steam
    ./vm
  ];

  home.packages = [
    pkgs.bottles
    pkgs.nsxiv
    # pkgs.flameshot
    pkgs.galculator
    # pkgs.kdeconnect
    # pkgs.kleopatra
    # pkgs.piper
    # pkgs.r2modman
    # pkgs.vlc

    # Browsers
    # pkgs.librewolf
    # pkgs.icecat
    pkgs.floorp
    pkgs.buku # browser indepenent bookmarks
    pkgs.bukubrow

    # pkgs.btrfs-assistant

    pkgs.thunderbird
    pkgs.keepassxc
    # (pkgs.xfce.thunar.override { thunarPlugins = [ pkgs.xfce.thunar-archive-plugin pkgs.xfce.thunar-volman ]; })
    # pkgs.gpodder
    pkgs.gparted

    # Game Dev
    # pkgs.godot
    # pkgs.aseprite
    pkgs.godot_4
    #pkgs.unityhub
    pkgs.blender
    pkgs.obs-studio

    pkgs.prismlauncher

    # Weeb Stuff
    pkgs.ani-cli
    pkgs.mangal
    pkgs.suwayomi-server

    # Socials
    pkgs.signal-desktop
    pkgs.zoom-us
    pkgs.slack

    # pkgs.jetbrains.idea-ultimate
    # pkgs.jetbrains.idea-community
    # pkgs.jetbrains.clion
    # pkgs.jetbrains.rust-rover
    pkgs.vscode
    # pkgs.android-studio
    pkgs.libreoffice

    pkgs.scrcpy

    pkgs.rclone-browser
    # pkgs.grsync

  ];


}
