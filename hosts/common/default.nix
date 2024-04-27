{ config, pkgs, lib, ... }:

{

  imports = [
    ./boot.nix
    ./packages.nix
    ./polkit.nix
    ./users.nix
  ];

}