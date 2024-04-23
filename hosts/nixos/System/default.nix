{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    ./system.nix
    ./users.nix
    ./polkit.nix
    ./packages.nix
    ./users.nix
    ./displaymanager.nix
    ./services.nix
    ./boot.nix
  ];


}
