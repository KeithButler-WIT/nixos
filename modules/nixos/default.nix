{ pkgs, lib, ... }:

{
  imports = [
    ./autologin.nix
    ./autoUpgrade.nix
    ./flatpak.nix
    ./hyprland.nix
    ./logitech.nix
    ./plasma6.nix
    ./steam.nix
    ./thunar.nix
    ./tuigreet.nix
    ./vm.nix
  ];

  autologin.enable = lib.mkDefault false;
  autoUpgrade.enable = lib.mkDefault false;
  flatpak.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault false;
  logitech.enable = lib.mkDefault true;
  plasma6.enable = lib.mkDefault false;
  steam.enable = lib.mkDefault true;
  thunar.enable = lib.mkDefault true;
  tuigreet.enable = lib.mkDefault true;
  vm.enable = lib.mkDefault true;

}
