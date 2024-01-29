{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    # You can also split up your configuration and import pieces of it here:
    ./hardware/amdgpu.nix
    ./hardware/bluetooth.nix
    ./hardware/opengl.nix
    ./hardware/printing.nix


    ./system.nix
    ./users.nix
    ./steam.nix
    ./polkit.nix
    ./packages.nix
    ./users.nix
    ./displaymanager.nix
    ./services.nix
    ./boot.nix
  ];
}
