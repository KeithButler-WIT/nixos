{ config, pkgs, ... }:

{

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiInstallAsRemovable = true;
    efiSupport = true;
    useOSProber = true;
    zfsSupport = true;
  };

  # boot.kernel.sysctl = { "vm.max_map_count" = 2147483642; }; # Not needed while steam.platformOptimizations is enabled

  # boot.supportedFilesystems = [ "zfs" ];
  # boot.zfs.forceImportRoot = false;
  boot.initrd.luks.devices."luks-ee0c8b1c-e042-492a-960d-df1fed98ec91".device = "/dev/disk/by-uuid/ee0c8b1c-e042-492a-960d-df1fed98ec91";
  networking.hostId = "934bebc5";

  # empty out /tmp on boot
  boot.tmp.cleanOnBoot = true;
  #boot.tmp.useTmpfs = true;
  #boot.tmp.tmpfsSize = "25%";

  systemd.services.zfs-mount.enable = true;
  # boot.zfs.extraPools = [ "zfs-1TB-BACKUP" "game_drive" ];
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;

  fileSystems."/run/media/keith/1TB-BACKUP" = {
    device = "zfs-1TB-BACKUP";
    fsType = "zfs";
    options = [
      # If you don't have this options attribute, it'll default to "defaults" 
      # boot options for fstab. Search up fstab mount options you can use
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
      "x-gvfs-show" # Shows in file managers
    ];
  };
  fileSystems."/run/media/keith/game_drive" = {
    device = "game-drive";
    fsType = "zfs";
    options = [
      # If you don't have this options attribute, it'll default to "defaults" 
      # boot options for fstab. Search up fstab mount options you can use
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
      "x-gvfs-show" # Shows in file managers
    ];
  };



}
