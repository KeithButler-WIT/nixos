{ pkgs, config, lib, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.streaming;
in {

  options.modules.services.streaming = {
    enable = mkBoolOpt false;
    plex.enable = mkBoolOpt false;
    jellyfin.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable (mkMerge [
    {
      # TODO: remove every user = userSettings.username;
      services.jellyseerr = {
        enable = true;
        openFirewall = true;
      };
      services.radarr = {
        enable = true;
        openFirewall = true;
        user = userSettings.username;
      };
      services.sonarr = {
        enable = true;
        openFirewall = true;
        user = userSettings.username;
      };
      services.jackett = {
        enable = true;
        openFirewall = true;
        user = userSettings.username;
      };
    }

    (mkIf (cfg.plex.enable) {
      services.plex = {
        enable = true;
        openFirewall = true;
        user = userSettings.username;
      };
    })

    (mkIf (cfg.jellyfin.enable) {
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
    })

  ]);
}
