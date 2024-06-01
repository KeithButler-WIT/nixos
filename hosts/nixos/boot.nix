{ config, pkgs, userSettings, ... }:

{

  # boot.kernel.sysctl = { "vm.max_map_count" = 2147483642; }; # Not needed while steam.platformOptimizations is enabled

  # boot.zfs.forceImportRoot = false;
  boot.initrd.luks.devices."luks-ee0c8b1c-e042-492a-960d-df1fed98ec91".device = "/dev/disk/by-uuid/ee0c8b1c-e042-492a-960d-df1fed98ec91";
  networking.hostId = "cb52f555";

  # Refuse ICMP echo requests on my desktop/laptop; nobody has any business
  # boot.kernel.sysctl."net.ipv4.icmp_echo_ignore_broadcasts" = 1;

  # boot.zfs.enabled = true;
  # boot.zfs.extraPools = [ "zfs-1TB-BACKUP" ];

  # fileSystems."/run/media/${userSettings.username}/1TB-BACKUP" = {
  #   device = "zfs-1TB-BACKUP/fs1";
  #   # device = "/dev/disk/by-uuid/16684118747979654910";
  #   fsType = "zfs";
  #   options = [
  #     "users" # Allows any user to mount and unmount
  #     "nofail" # Prevent system from failing if this drive doesn't mount
  #     "x-gvfs-show" # Shows in file managers
  #   ];
  # };

  fileSystems."/run/media/${userSettings.username}/game-drive" = {
    # device = "game-drive/fs1";
    device = "/dev/disk/by-uuid/253c00e5-e419-4d05-80d1-cd98584bae1b";
    fsType = "ext4";
    options = [
      # If you don't have this options attribute, it'll default to "defaults" 
      # boot options for fstab. Search up fstab mount options you can use
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
      "x-gvfs-show" # Shows in file managers
    ];
  };
  # fileSystems."/mnt/4TB-BACKUP" = {
  fileSystems."/run/media/${userSettings.username}/4TB-BACKUP" = {
    # device = "game-drive/fs1";
    device = "/dev/disk/by-uuid/B9DD-8882";
    fsType = "exfat";
    options = [
      # If you don't have this options attribute, it'll default to "defaults" 
      # boot options for fstab. Search up fstab mount options you can use
      #"users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
      "x-gvfs-show" # Shows in file managers
    ];
  };


}
