# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

with lib.my;
{

  imports = [
    ./hardware-configuration.nix
    ./boot.nix
  ];

  modules = {
    autologin.enable = true;
    # autoUpgrade.enable = true;
    flatpak.enable = true;
    nix-ld.enable = true;
    stylix.enable = true;
    vm.enable = true;
    desktop = {
      enable = true;
      hyprland.enable = true;
      # plasma6.enable = true;
      # thunar.enable = true;
      tuigreet.enable = true;
      gaming = {
        steam.enable = true;
      };
    };
    # dev = { };
    # editors = {
    #   emacs.enable = true;
    # };
    hardware = {
      audio.enable = true;
      amd.enable = true;
      # bluetooth.enable = true;
      # nvidia.enable = true;
      logitech.enable = true;
      fs = {
        enable = true;
        ssd.enable = true;
        zfs.enable = true;
      };
    };
    services = {
      containers = {
        enable = true;
        distrobox.enable = true;
        # docker.enable = true;
        podman.enable = true;
      };
      # firewall.enable = true;
      mullvad-vpn.enable = true;
      power-management.enable = true;
      printer.enable = true;
      ssh.enable = true;
      streaming = {
        enable = true;
        # plex.enable = true;
        jellyfin.enable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    pika-backup
    haskell-language-server
    stack
    rclone
    # inkscape
    ghc
    conda

    (unityhub.override {
      extraPkgs = fhsPkgs: [
        fhsPkgs.harfbuzz
        fhsPkgs.libogg
      ];
    })
  ];

  services.gvfs.enable = true;

}
