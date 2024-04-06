{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    ./hardware/amdgpu.nix
    ./hardware/nvidia.nix
    ./hardware/opengl.nix

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
