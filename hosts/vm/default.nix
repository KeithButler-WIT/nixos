# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  ...
}:

{

  imports = [
    ./hardware-configuration.nix
  ];

  modules = {
    autologin.enable = true;
    # nix-ld.enable = true;
    stylix.enable = true;
    desktop = {
      enable = true;
      hyprland.enable = true;
      tuigreet.enable = true;
      # thunar.enable = true;
    };
    # dev = { };
    # editors = {
    #   emacs.enable = true;
    # };
    hardware = {
      # audio.enable = true;
      amd.enable = true;
      # logitech.enable = true;
      fs = {
        enable = true;
        ssd.enable = true;
        zfs.enable = true;
      };
    };
    # services = {
    # ssh.enable = true;
    # };
  };

  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  }; # Not needed while steam.platformOptimizations is enabled

  boot.zfs.devNodes = "/dev/disk/by-partuuid";

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    spice-webdavd.enable = true;
  };

  # fix for spice-vdagentd not starting in wms
  systemd.user.services.spice-agent = {
    enable = true;
    wantedBy = [ "graphical-session.target" ];
    # serviceConfig = {
    #   ExecStart = "${lib.getExe' pkgs.spice-vdagent "spice-vdagent"} -x";
    # };
    unitConfig = {
      ConditionVirtualization = "vm";
      Description = "Spice guest session agent";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
  };

}
