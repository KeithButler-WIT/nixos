{ config, options, lib, pkgs, ... }:

with lib;
let cfg = config.modules.hardware.fs;
in {
  options.modules.hardware.fs = {
    enable = mkEnableOption "enables fs";
    zfs.enable = mkEnableOption "enables zfs";
    ssd.enable = mkEnableOption "enables ssd";
    # TODO automount.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable (mkMerge [
    {
      programs.udevil.enable = true;

      # Support for more filesystems, mostly to support external drives
      environment.systemPackages = with pkgs; [
        sshfs
        exfat # Windows drives
        ntfs3g # Windows drives
        hfsprogs # MacOS drives
      ];
    }

    (mkIf (!cfg.zfs.enable && cfg.ssd.enable) {
      services.fstrim.enable = true;
    })

    (mkIf cfg.zfs.enable (mkMerge [
      {
        boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
        boot.zfs.forceImportRoot = false; # TODO: check if needed 
        boot.loader.grub.copyKernels = true;
        boot.supportedFilesystems = [ "zfs" ];
        boot.zfs.devNodes = "/dev/disk/by-partuuid";
        services.zfs.autoScrub.enable = true;
        systemd.services.zfs.enable = true;
        systemd.services.zfs-import.enable = true;
        systemd.services.zfs-mount.enable = false;
      }

      (mkIf cfg.ssd.enable {
        # Will only TRIM SSDs; skips over HDDs
        services.fstrim.enable = false;
        services.zfs.trim.enable = true;
      })
    ]))
  ]);
}
