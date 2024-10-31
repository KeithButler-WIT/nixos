{ config, isVm, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.fs;
in {
  options.modules.hardware.fs = {
    enable = mkBoolOpt false;
    zfs.enable = mkBoolOpt false;
    ssd.enable = mkBoolOpt false;
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
        boot = {
          # booting with zfs
          supportedFilesystems.zfs = true;
          # kernelPackages = pkgs.linuxPackages_xanmod_latest;
          kernelPackages = pkgs.zfs.latestCompatibleLinuxPackages;
          zfs = {
            devNodes =
              if isVm then
                "/dev/disk/by-partuuid"
              # use by-id for intel mobo when not in a vm
              else if config.hardware.cpu.intel.updateMicrocode then
                "/dev/disk/by-id"
              else
                "/dev/disk/by-partuuid";

            package = pkgs.zfs_unstable;
            requestEncryptionCredentials = config.custom.zfs.encryption;
          };
        };

        services.zfs = {
          autoScrub.enable = true;
          trim.enable = true;
        };

        # 16GB swap
        swapDevices = [ { device = "/dev/disk/by-label/SWAP"; } ];

        # standardized filesystem layout
        # TODO: Uncomment before running under a zfs system
        # fileSystems = {
        #   # NOTE: root and home are on tmpfs
        #   # root partition, exists only as a fallback, actual root is a tmpfs
        #   "/" = {
        #     device = "zroot/root";
        #     fsType = "zfs";
        #     neededForBoot = true;
        #   };

        #   # boot partition
        #   "/boot" = {
        #     device = "/dev/disk/by-label/NIXBOOT";
        #     fsType = "vfat";
        #   };

        #   "/nix" = {
        #     device = "zroot/nix";
        #     fsType = "zfs";
        #   };

        #   "/tmp" = {
        #     device = "zroot/tmp";
        #     fsType = "zfs";
        #   };

        #   "/persist" = {
        #     device = "zroot/persist";
        #     fsType = "zfs";
        #     neededForBoot = true;
        #   };

        #   "/persist/cache" = {
        #     device = "zroot/cache";
        #     fsType = "zfs";
        #     neededForBoot = true;
        #   };
        # };

        systemd.services = {
          # https://github.com/openzfs/zfs/issues/10891
          systemd-udev-settle.enable = false;
          # snapshot dirs sometimes not accessible
          # https://github.com/NixOS/nixpkgs/issues/257505#issuecomment-2348313665
          zfs-mount = {
            serviceConfig = {
              ExecStart = [ "${lib.getExe' pkgs.util-linux "mount"} -t zfs zroot/persist -o remount" ];
            };
          };
        };
      }

      (mkIf cfg.ssd.enable {
        # Will only TRIM SSDs; skips over HDDs
        services.fstrim.enable = false;
      })
    ]))
  ]);
}
