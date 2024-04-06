{ config, pkgs, lib, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
    steam-run
    steamcmd
    progress
    rsync
    gnumake
    gnupg
    curl
    htop
    btop
    gnumake
    xdragon
    wallust # better pywal
    # cava
    numlockx
    w3m
    ripgrep
    entr

    # Home Backup
    pika-backup

    # System management
    htop
    btop

    stack

    killall
    zip
    unzip
    light
    pass
    yt-dlp
    feh
    wget
    gnupg
    trash-cli
    ncdu # disk space management
    xorg.xhost # needed to run gparted on wayland

    rsync
    rclone

    inkscape

    ghc
    borgmatic

    pavucontrol

    floorp
    conda
  ];

  programs.java.enable = true;

  programs.fuse.userAllowOther = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

}
