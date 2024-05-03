{ pkgs, lib, systemSettings, userSettings, ... }:

{

  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    bind
    cached-nix-shell
    git
    vim
    wget
    gnumake
    unzip

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
