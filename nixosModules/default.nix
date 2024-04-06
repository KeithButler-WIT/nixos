{ pkgs, lib, ... }:

{
  imports = [
    ./flatpak.nix
    ./plasma6.nix
    ./steam.nix
    ./thunar.nix
    ./vm.nix
  ];

  flatpak.enable = lib.mkDefault true;
  plasma6.enable = lib.mkDefault false;
  steam.enable = lib.mkDefault true;
  thunar.enable = lib.mkDefault true;
  vm.enable = lib.mkDefault true;

}
