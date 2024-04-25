{ pkgs, lib, ... }:

{
  imports = [
    ./desktop/hyprland.nix
    ./desktop/plasma6.nix
    ./desktop/thunar.nix
    ./desktop/tuigreet.nix
    ./desktop
    ./editors/emacs.nix
    ./gaming/steam.nix
    ./hardware/amd.nix
    ./hardware/audio.nix
    ./hardware/bluetooth.nix
    ./hardware/fs.nix
    ./hardware/nvidia.nix
    ./hardware/logitech.nix
    ./autologin.nix
    ./autoUpgrade.nix
    ./services/docker.nix
    ./services/firewall.nix
    ./services/mullvad-vpn.nix
    ./services/streaming.nix
    ./services/power-management.nix
    ./services/printer.nix
    ./services/ssh.nix
    ./vm.nix
    ./flatpak.nix
    ./nix-ld.nix
  ];

  modules = {
    autologin.enable = lib.mkDefault false;
    autoUpgrade.enable = lib.mkDefault false;
    flatpak.enable = lib.mkDefault false;
    nix-ld.enable = lib.mkDefault false;
    vm.enable = lib.mkDefault false;
    desktop = {
      enable = lib.mkDefault false;
      hyprland.enable = lib.mkDefault false;
      plasma6.enable = lib.mkDefault false;
      thunar.enable = lib.mkDefault false;
      tuigreet.enable = lib.mkDefault false;
    };
    editors = {
      emacs.enable = lib.mkDefault false;
    };
    gaming = {
      steam.enable = lib.mkDefault false;
    };
    services = {
      docker.enable = lib.mkDefault false;
      firewall.enable = lib.mkDefault false;
      mullvad-vpn.enable = lib.mkDefault false;
      power-management.enable = lib.mkDefault false;
      printer.enable = lib.mkDefault false;
      ssh.enable = lib.mkDefault false;
      streaming = {
        enable = lib.mkDefault false;
        plex.enable = lib.mkDefault false;
        jellyfin.enable = lib.mkDefault false;
      };
    };
    hardware = {
      audio.enable = lib.mkDefault false;
      amd.enable = lib.mkDefault false;
      bluetooth.enable = lib.mkDefault false;
      nvidia.enable = lib.mkDefault false;
      logitech.enable = lib.mkDefault false;
      fs = {
        enable = lib.mkDefault false;
        ssd.enable = lib.mkDefault false;
        zfs.enable = lib.mkDefault false;
      };
    };
  };

}
