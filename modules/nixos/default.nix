{ pkgs, lib, ... }:

{
  imports = [
    ./hardware/amd.nix
    ./hardware/audio.nix
    ./hardware/bluetooth.nix
    ./hardware/fs.nix
    ./hardware/nvidia.nix
    ./autologin.nix
    ./autoUpgrade.nix
    ./services/docker.nix
    ./emacs.nix
    ./flatpak.nix
    ./hyprland.nix
    ./logitech.nix
    ./nix-ld.nix
    ./plasma6.nix
    ./services/plex.nix
    ./services/power-management.nix
    ./services/printer.nix
    ./services/ssh.nix
    ./steam.nix
    ./thunar.nix
    ./tuigreet.nix
    ./vm.nix
  ];

  autologin.enable = lib.mkDefault false;
  autoUpgrade.enable = lib.mkDefault false;
  emacs.enable = lib.mkDefault true;
  flatpak.enable = lib.mkDefault false;
  hyprland.enable = lib.mkDefault false;
  logitech.enable = lib.mkDefault true;
  nix-ld.enable = lib.mkDefault true;
  plasma6.enable = lib.mkDefault false;
  modules = {
    services = {
      docker.enable = lib.mkDefault false;
      plex.enable = lib.mkDefault false;
      power-management.enable = lib.mkDefault false;
      printer.enable = lib.mkDefault true;
      ssh.enable = lib.mkDefault true;
    };
    hardware = {
      audio.enable = lib.mkDefault false;
      amd.enable = lib.mkDefault false;
      bluetooth.enable = lib.mkDefault false;
      nvidia.enable = lib.mkDefault false;
      fs = {
        enable = lib.mkDefault false;
        ssd.enable = lib.mkDefault false;
        zfs.enable = lib.mkDefault false;
      };
    };
  };
  steam.enable = lib.mkDefault false;
  thunar.enable = lib.mkDefault true;
  tuigreet.enable = lib.mkDefault false;
  vm.enable = lib.mkDefault false;

}
