{ pkgs, config, lib, userSettings, ... }:

with lib;
let cfg = config.modules.services.streaming;
in {

  options.modules.services.streaming.enable =
    mkEnableOption "enables streaming";

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
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      user = userSettings.username;
    };
    environment.systemPackages = [
      pkgs.jellyfin
      pkgs.jellyfin-web
      pkgs.jellyfin-ffmpeg
    ];
  };

}
