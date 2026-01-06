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
    lidarr.enable = mkBoolOpt false;
    prowlarr.enable = mkBoolOpt false;
    audiobookshelf.enable = mkBoolOpt false;
    readarr.enable = mkBoolOpt false;
    navidrome.enable = mkBoolOpt false;
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
    (mkIf (!cfg.prowlarr.enable && cfg.jackett.enable) {
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
      services.jellyseerr = {
        enable = true;
        openFirewall = true;
      };
      services.jellyfin = {
        enable = true;
        openFirewall = true;
        user = userSettings.username;
        transcoding = {
          enableHardwareEncoding = true;
          hardwareEncodingCodecs.av1 = true;
          hardwareDecodingCodecs.av1 = true;
          deleteSegments = true;
        };
        #dataDir = "/home/${userSettings.username}/.local/share/jellyfin/data";
        #cacheDir = "/home/${userSettings.username}/.local/share/jellyfin/cache";
      };
      environment.systemPackages = [
        pkgs.jellyfin
        pkgs.jellyfin-web
        pkgs.jellyfin-ffmpeg
      ];
    })

    # lidarr
    (mkIf cfg.lidarr.enable {
      services.lidarr = {
        enable = true;
        openFirewall = true;
        user = userSettings.username;
      };
    })
    # readarr
    (mkIf cfg.readarr.enable {
      services.readarr = {
        enable = true;
        openFirewall = true;
        user = userSettings.username;
      };
    })
    (mkIf cfg.navidrome.enable {
      services.navidrome = {
        enable = true;
        openFirewall = true;
        user = userSettings.username;
	settings = {
	# MusicFolder = "/run/media/keith/4TB-BACKUP/media-store/Music";
	MusicFolder = "/home/${userSettings.username}/Music";
	};
        #dataDir = "/home/${userSettings.username}/.local/share/radarr";
      };
    })
    # audiobookshelf
    (mkIf cfg.audiobookshelf.enable {
      services.audiobookshelf = {
        enable = true;
        openFirewall = true;
        user = userSettings.username;
      };
    })
    # prowlerr instead of jackett
    (mkIf (cfg.prowlarr.enable && !cfg.jackett.enable) {
      services.prowlarr = {
        enable = true;
        openFirewall = true;
      };
    })
  ]);
}
