{
  pkgs,
  config,
  lib,
  userSettings,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.services.streaming;
in {
  options.modules.services.streaming = {
    enable = mkBoolOpt false;
    plex.enable = mkBoolOpt false;
    jellyfin.enable = mkBoolOpt false;
    radarr.enable = mkBoolOpt false;
    sonarr.enable = mkBoolOpt false;
    jackett.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.radarr.enable {
      services.radarr = {
        enable = true;
        openFirewall = true;
        user = userSettings.username;
        #dataDir = "/home/${userSettings.username}/.local/share/radarr";
      };
    })
    (mkIf cfg.sonarr.enable {
      services.sonarr = {
        enable = true;
        # skip checks for faster builds
        package = pkgs.sonarr.overrideAttrs {doCheck = false;};
        openFirewall = true;
        user = userSettings.username;
        #dataDir = "/home/${userSettings.username}/.local/share/sonarr";
      };
    })
    (mkIf cfg.jackett.enable {
      services.jackett = {
        enable = true;
        openFirewall = true;
        user = userSettings.username;
        #dataDir = "/home/${userSettings.username}/.local/share/jackett";
      };
    })
    (mkIf cfg.plex.enable {
      services.plex = {
        enable = true;
        openFirewall = true;
        user = userSettings.username;
        #dataDir = "/home/${userSettings.username}/.local/share/plex";
      };
    })
    (mkIf cfg.jellyfin.enable {
      # TODO: remove every user = userSettings.username;
      services.jellyseerr = {
        enable = true;
        openFirewall = true;
      };
      services.jellyfin = {
        enable = true;
        openFirewall = true;
        user = userSettings.username;
        #dataDir = "/home/${userSettings.username}/.local/share/jellyfin/data";
        #cacheDir = "/home/${userSettings.username}/.local/share/jellyfin/cache";
      };
      environment.systemPackages = [
        pkgs.jellyfin
        pkgs.jellyfin-web
        pkgs.jellyfin-ffmpeg
      ];
    })
  ]);
}
