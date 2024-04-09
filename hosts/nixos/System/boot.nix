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

  # boot.zfs.forceImportRoot = false;
  boot.initrd.luks.devices."luks-ee0c8b1c-e042-492a-960d-df1fed98ec91".device = "/dev/disk/by-uuid/ee0c8b1c-e042-492a-960d-df1fed98ec91";
  networking.hostId = "cb52f555";

  # empty out /tmp on boot
  boot.tmp.cleanOnBoot = true;
  #boot.tmp.useTmpfs = true;
  #boot.tmp.tmpfsSize = "25%";

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  boot.kernelParams = [
    # "nohibernate"
    "v4l2loopback"
    # "quiet"
    # "splash"
    "vga=current"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.zfs.forceImportRoot = false;
  boot.supportedFilesystems = [ "zfs" ];

  # boot.zfs.enabled = true;
  # boot.zfs.extraPools = [ "zfs-1TB-BACKUP" "game_drive" ];
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;

  systemd.services.zfs.enable = true;
  systemd.services.zfs-import.enable = true;
  systemd.services.zfs-mount.enable = false;

  fileSystems."/run/media/keith/1TB-BACKUP" = {
    device = "zfs-1TB-BACKUP/fs1";
    # device = "/dev/disk/by-uuid/16684118747979654910";
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
    device = "game_drive/fs1";
    # device = "/dev/disk/by-uuid/1833100989279534287";
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
