{ config, lib, pkgs, ... }:

{

  imports = [
    ./alacritty # requires nixGL on non-nixos
    ./discord
    ./dunst
    # ./firefox
    ./gtk
    ./hyprland
    ./kitty # requires nixGL on non-nixos
    # ./mako
    ./mpv
    ./qutebrowser
    ./steam
    ./vm
  ];

  home.packages = with pkgs; [
    bottles
    nsxiv
    # pkgs.flameshot
    galculator
    # pkgs.kdeconnect
    # pkgs.kleopatra
    # pkgs.piper
    r2modman
    # pkgs.vlc

    # Browsers
    # pkgs.librewolf
    # pkgs.icecat
    floorp
    buku # browser indepenent bookmarks
    bukubrow

    # pkgs.btrfs-assistant

    thunderbird
    keepassxc
    # pkgs.gpodder
    # pkgs.gparted

    # Game Dev
    # pkgs.godot
    # pkgs.aseprite
    godot_4
    #pkgs.unityhub
    blender
    obs-studio

    prismlauncher

    # Weeb Stuff
    ani-cli
    mangal
    suwayomi-server

    # Socials
    signal-desktop
    # zoom-us
    slack

    # pkgs.jetbrains.idea-ultimate
    # pkgs.jetbrains.idea-community
    # pkgs.jetbrains.clion
    # pkgs.jetbrains.rust-rover
    vscode
    # pkgs.android-studio
    libreoffice

    scrcpy

    rclone-browser
    xdotool
  ];

}
