{ pkgs, lib, ... }:

{
  imports = [
    ./autologin.nix
    ./flatpak.nix
    ./hyprland.nix
    ./plasma6.nix
    ./steam.nix
    ./thunar.nix
    ./tuigreet.nix
    ./vm.nix
  ];

  autologin.enable = lib.mkDefault false;
  flatpak.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault false;
  plasma6.enable = lib.mkDefault false;
  steam.enable = lib.mkDefault true;
  thunar.enable = lib.mkDefault true;
  tuigreet.enable = lib.mkDefault true;
  vm.enable = lib.mkDefault true;

}
