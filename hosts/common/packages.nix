{ pkgs, lib, systemSettings, userSettings, ... }:

{

  environment.systemPackages = with pkgs; [
    bind
    cached-nix-shell
    git
    vim
    wget
    gnumake
    zip
    unzip

    cachix
    curl
    nixpkgs-fmt
    gcc
    grc
    ripgrep
    progress
    rsync
    gnupg
    curl
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
    pass
    feh
    gnupg
    trash-cli
    ncdu # disk space management
    xorg.xhost # needed to run gparted on wayland
    rsync
  ];

}
