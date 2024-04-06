{ pkgs, config, lib, userSettings, ... }:

{

  options = {
    plex.enable =
      lib.mkEnableOption "enables plex";
  };

  config = lib.mkIf config.plex.enable {
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
