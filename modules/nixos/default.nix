{ pkgs, lib, ... }:

{
  imports = [
    ./autologin.nix
    ./autoUpgrade.nix
    ./bluetooth.nix
    ./flatpak.nix
    ./hyprland.nix
    ./logitech.nix
    ./nix-ld.nix
    ./plasma6.nix
    ./power-management.nix
    ./printer.nix
    ./ssh.nix
    ./steam.nix
    ./thunar.nix
    ./tuigreet.nix
    ./vm.nix
  ];

  autologin.enable = lib.mkDefault false;
  autoUpgrade.enable = lib.mkDefault false;
  bluetooth.enable = lib.mkDefault false;
  flatpak.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault false;
  logitech.enable = lib.mkDefault true;
  nix-ld.enable = lib.mkDefault true;
  plasma6.enable = lib.mkDefault false;
  power-management.enable = lib.mkDefault true;
  printer.enable = lib.mkDefault true;
  ssh.enable = lib.mkDefault true;
  steam.enable = lib.mkDefault true;
  thunar.enable = lib.mkDefault true;
  tuigreet.enable = lib.mkDefault true;
  vm.enable = lib.mkDefault false;

}
