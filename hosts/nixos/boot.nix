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
}
