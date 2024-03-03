{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    ./hardware/amdgpu.nix
    ./hardware/nvidia.nix
    ./hardware/bluetooth.nix
    ./hardware/opengl.nix
    ./hardware/printing.nix
    ./hardware/power.nix

    ./flatpak.nix
    ./system.nix
    ./users.nix
    ./steam.nix
    ./polkit.nix
    ./packages.nix
    ./users.nix
    ./displaymanager.nix
    ./services.nix
    ./boot.nix
    ./vm.nix
  ];
}
