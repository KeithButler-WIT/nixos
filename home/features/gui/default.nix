{ config, lib, pkgs, ... }:

{

  imports = [
    ./alacritty # requires nixGL on non-nixos
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
    # ./spicetify # Requires spotify premium
  ];

  home.packages = [
    pkgs.bottles
    pkgs.nsxiv
    pkgs.flameshot
    pkgs.galculator
    pkgs.kdeconnect
    pkgs.kleopatra
    pkgs.piper
    # pkgs.r2modman
    # pkgs.vlc

    # Browsers
    # pkgs.librewolf
    # pkgs.icecat
    pkgs.floorp
    pkgs.tor-browser-bundle-bin
    pkgs.buku # browser indepenent bookmarks
    pkgs.bukubrow

    # pkgs.btrfs-assistant

    pkgs.thunderbird
    pkgs.mullvad-vpn
    pkgs.keepassxc
    # (pkgs.xfce.thunar.override { thunarPlugins = [ pkgs.xfce.thunar-archive-plugin pkgs.xfce.thunar-volman ]; })
    pkgs.gpodder
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
    # pkgs.discord
    # pkgs.betterdiscordctl
    pkgs.discord-screenaudio
    pkgs.signal-desktop
    pkgs.zoom-us
    pkgs.slack

    # pkgs.jetbrains.idea-ultimate
    pkgs.jetbrains.idea-community
    pkgs.jetbrains.clion
    pkgs.jetbrains.rust-rover
    pkgs.vscode
    # pkgs.android-studio
    pkgs.libreoffice

    pkgs.scrcpy

    pkgs.rclone-browser
    pkgs.grsync

  ];


}
