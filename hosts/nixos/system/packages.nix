{ config, pkgs, lib, inputs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # inputs.nix-gaming.packages.${pkgs.system}.steam
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

    w3m
    ripgrep
    entr

    # System management
    htop
    btop

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
  ];

  # Enable nix ld
  programs.nix-ld = {
    enable = true;
    # Sets up all the libraries to load
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      fuse3
      icu
      zlib
      nss
      openssl
      curl
      expat
      # ...
    ];
  };

  programs.java.enable = true;

  programs.fuse.userAllowOther = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.dconf.enable = true;
  programs.virt-manager.enable = true;

  virtualisation.libvirtd.enable = true;

}
