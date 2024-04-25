{ pkgs, config, lib, inputs, ... }:

{

  imports = [
    ./boot.nix
    ./polkit.nix
    ./users.nix
  ];

}
