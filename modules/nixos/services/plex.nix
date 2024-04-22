{ pkgs, config, lib, userSettings, ... }:

with lib;
let cfg = config.modules.services.plex;
in {

  options.modules.services.plex.enable =
    mkEnableOption "enables plex";

  config = mkIf cfg.enable {
    services.plex = {
      enable = true;
      openFirewall = true;
      user = userSettings.username;
    };
    services.jellyseerr = {
      enable = true;
      openFirewall = true;
    };
  };

}
