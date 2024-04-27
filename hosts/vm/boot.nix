{ config, pkgs, userSettings, ... }:

{

  boot.kernel.sysctl = { "vm.max_map_count" = 2147483642; }; # Not needed while steam.platformOptimizations is enabled

}
