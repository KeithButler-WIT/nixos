{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.syncthing;
in {

  options.modules.services.syncthing.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      # openDefaultPorts = true;
    };
    # services.syncthing.tray.enable = true;
  };

}
