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

    # Home Backup
    pika-backup

    haskell-language-server
    stack
    rclone
    inkscape
    ghc
    borgmatic
    pavucontrol
    floorp
    conda
    yt-dlp
    light

    # System management
    htop
    btop

    w3m
    ripgrep
    entr

    killall
    zip
    unzip
    pass
    feh
    wget
    gnupg
    trash-cli
    ncdu # disk space management
    xorg.xhost # needed to run gparted on wayland
    rsync
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
