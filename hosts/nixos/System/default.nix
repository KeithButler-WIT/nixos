{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    ./hardware/amdgpu.nix
    ./hardware/nvidia.nix
    ./hardware/bluetooth.nix
    ./hardware/opengl.nix
    ./hardware/printing.nix
    ./hardware/power.nix

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
