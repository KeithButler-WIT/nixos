# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{

  imports = [
    ./hardware-configuration.nix
    ./boot.nix
  ];

  modules = {
    autologin.enable = true;
    # autoUpgrade.enable = true;
    flatpak.enable = true;
    nix-ld.enable = true;
    vm.enable = true;
    desktop = {
      enable = true;
      hyprland.enable = true;
      # plasma6.enable = true;
      thunar.enable = true;
      tuigreet.enable = true;
    };
    editors = {
      emacs.enable = true;
    };
    gaming = {
      steam.enable = true;
    };
    services = {
      docker.enable = true;
      # firewall.enable = true;
      mullvad-vpn.enable = true;
      power-management.enable = true;
      printer.enable = true;
      ssh.enable = true;
      streaming = {
        enable = true;
        # plex.enable = true;
        jellyfin.enable = true;
      };
    };
    hardware = {
      audio.enable = true;
      amd.enable = true;
      bluetooth.enable = true;
      # nvidia.enable = true;
      logitech.enable = true;
      fs = {
        enable = true;
        ssd.enable = true;
        zfs.enable = true;
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
