{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    ./flatpak.nix
    ./plasma6.nix
    ./steam.nix
    ./thunar.nix
    ./vm.nix
  ];

  flatpak.enable = true;
  plasma6.enable = false;
  steam.enable = true;
  thunar.enable = true;
  vm.enable = true;

}
