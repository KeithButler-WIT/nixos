{ config, pkgs, lib, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cachix
    curl
    nixpkgs-fmt
    git
    gcc
    grc
    ripgrep
    vim
    wget
    progress
    rsync
    gnumake
    gnupg
    curl
    gnumake
    xdragon
    # cava
    numlockx
    yt-dlp
    light
    # System management
    htop
    btop
    w3m
    entr
    killall
    zip
    unzip
    pass
    feh
    gnupg
    trash-cli
    ncdu # disk space management
    xorg.xhost # needed to run gparted on wayland
    rsync
  ];

}
