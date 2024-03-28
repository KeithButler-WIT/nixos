{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    ./flatpak.nix
    ./steam.nix
    ./vm.nix
  ];

  flatpak.enable = true;
  steam.enable = true;
  vm.enable = true;
  
}
