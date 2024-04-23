{ config, lib, pkgs, userSettings, ... }:

with lib;
let cfg = config.modules.vm;
in {

  options.modules.vm.enable =
    mkEnableOption "enables vm";

  config = mkIf cfg.enable {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };

}
