{
  config,
  isVm,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.hardware.fs;
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

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/487106e6-1c6d-48fc-9b42-4ed75085bce6";
          fsType = "ext4";
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/0D5D-3591";
          fsType = "vfat";
        };
      };

      boot.initrd.luks.devices."luks-d653e092-1b1c-4f91-8b7d-d82f2cf4be28".device = "/dev/disk/by-uuid/d653e092-1b1c-4f91-8b7d-d82f2cf4be28";

      # 16GB swap
      # swapDevices = [{ device = "/dev/disk/by-label/SWAP"; }];
      swapDevices = [{device = "/dev/disk/by-uuid/e0f083ce-a92f-4533-a2b8-94af1beb7a30";}];
    })

    (mkIf cfg.zfs.enable (mkMerge [
      {
        # services.scx.enable = true;
        boot = {
          # booting with zfs
          supportedFilesystems.zfs = true;
          kernelPackages = pkgs.linuxPackages_cachyos;
          zfs = {
            devNodes =
              if isVm
              then "/dev/disk/by-partuuid"
              # use by-id for intel mobo when not in a vm
              else if config.hardware.cpu.intel.updateMicrocode
              then "/dev/disk/by-id"
              else "/dev/disk/by-partuuid";

            package = pkgs.zfs;
            # requestEncryptionCredentials = config.custom.zfs.encryption;
          };
        };

        services.zfs = {
          autoScrub.enable = true;
          trim.enable = true;
        };

        # 16GB swap
        swapDevices = [{device = "/dev/disk/by-label/SWAP";}];

        # standardized filesystem layout
        fileSystems = {
          # NOTE: root and home are on tmpfs
          # root partition, exists only as a fallback, actual root is a tmpfs
          "/" = {
            device = "zroot/root";
            fsType = "zfs";
            neededForBoot = true;
          };

          # boot partition
          "/boot" = {
            device = "/dev/disk/by-label/NIXBOOT";
            fsType = "vfat";
          };

          "/nix" = {
            device = "zroot/nix";
            fsType = "zfs";
          };

          "/tmp" = {
            device = "zroot/tmp";
            fsType = "zfs";
          };

          "/persist" = {
            device = "zroot/persist";
            fsType = "zfs";
            neededForBoot = true;
          };

          "/persist/cache" = {
            device = "zroot/cache";
            fsType = "zfs";
            neededForBoot = true;
          };
        };

        systemd.services = {
          # https://github.com/openzfs/zfs/issues/10891
          systemd-udev-settle.enable = false;
          # snapshot dirs sometimes not accessible
          # https://github.com/NixOS/nixpkgs/issues/257505#issuecomment-2348313665
          zfs-mount = {
            serviceConfig = {
              ExecStart = ["${lib.getExe' pkgs.util-linux "mount"} -t zfs zroot/persist -o remount"];
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
