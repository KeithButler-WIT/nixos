{userSettings, ...}: {
  # boot.kernel.sysctl = { "vm.max_map_count" = 2147483642; }; # Not needed while steam.platformOptimizations is enabled

  # boot.zfs.forceImportRoot = false;
  # boot.initrd.luks.devices."luks-ee0c8b1c-e042-492a-960d-df1fed98ec91".device = "/dev/disk/by-uuid/ee0c8b1c-e042-492a-960d-df1fed98ec91";
  #networking.hostId = "cb52f555";
  networking.hostId = "437529cb";

  # Refuse ICMP echo requests on my desktop/laptop; nobody has any business
  # boot.kernel.sysctl."net.ipv4.icmp_echo_ignore_broadcasts" = 1;

  # boot.zfs.enabled = true;
  # boot.zfs.extraPools = ["media" "backup"];
  boot.zfs.extraPools = ["media"];

  fileSystems = {
    "/run/media/${userSettings.username}/game-drive" = {
      # device = "game-drive/fs1";
      device = "/dev/disk/by-label/game-drive";
      fsType = "ext4";
      options = [
        # If you don't have this options attribute, it'll default to "defaults"
        # boot options for fstab. Search up fstab mount options you can use
        "users" # Allows any user to mount and unmount
        "nofail" # Prevent system from failing if this drive doesn't mount
        "x-gvfs-show" # Shows in file managers
      ];
    };
  };
}
