{ pkgs, lib, inputs, systemSettings, userSettings, ... }:

{

  environment.systemPackages = with pkgs; [
    git
    nixd
    nixfmt-rfc-style
    nixpkgs-fmt
    shfmt

    cachix
    curl
    nixpkgs-fmt
    bind
    cached-nix-shell
    git
    vim
    wget
    gnumake
    zip
    unzip
    coreutils-full
    egl-wayland
    gcc
    grc
    ripgrep
    progress
    gnupg
    numlockx
    light
    usbutils
    oversteer

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
    rclone
    unrar
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

}
