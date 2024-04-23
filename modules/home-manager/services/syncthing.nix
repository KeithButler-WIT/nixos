{ pkgs, config, lib, ... }:

with lib;
let cfg = config.modules.services.syncthing;
in {

  options.modules.services.syncthing.enable =
    mkEnableOption "enables syncthing";

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      # openDefaultPorts = true;
    };
    # services.syncthing.tray.enable = true;
  };

}
