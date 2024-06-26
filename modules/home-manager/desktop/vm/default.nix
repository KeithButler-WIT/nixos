{ config, lib, pkgs, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.vm;
in {

  options.modules.desktop.vm.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    # dconf.settings = {
    #   "org/virt-manager/virt-manager/connections" = {
    #     autoconnect = [ "qemu:///system" ];
    #     uris = [ "qemu:///system" ];
    #   };
    # };
  };

}
