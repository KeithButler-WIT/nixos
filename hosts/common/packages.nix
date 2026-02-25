{
  pkgs,
  lib,
  inputs,
  systemSettings,
  userSettings,
  ...
}: {
  environment.systemPackages = with pkgs; [
    git
    nixd
    nixfmt
    shfmt

    cachix
    curl
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
    trash-cli
    ncdu # disk space management
    xhost # needed to run gparted on wayland
    rsync
    rclone
    unrar
    bonk # touch / mkdir replacer

    lm_sensors
    pandoc # TODO: move to markdown module # format markdown files
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
