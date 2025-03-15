{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.browsers.floorp;
in {
  options.modules.desktop.browsers.floorp.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      buku # browser indepenent bookmarks
      bukubrow
    ];

    stylix.targets.floorp.profileNames = ["main"];
    stylix.targets.floorp.colorTheme.enable = true;

    programs.floorp = {
      enable = true;
      languagePacks = ["en-GB"];
      # TODO: Continue editing
      profiles = {
        main = {
          extensions.force = true;
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            sponsorblock
            bukubrow
            torrent-control
            sidebery
            youtube-shorts-block
            libredirect
            downthemall
            darkreader
            bitwarden
            clearurls
            localcdn
            terms-of-service-didnt-read
            search-by-image
            duckduckgo-privacy-essentials
            firefox-color # stylix coloring
            #privacy-badger
          ];
          search = {
            default = "DuckDuckGo";
            engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@np"];
              };

              "NixOS Wiki" = {
                urls = [{template = "https://wiki.nixos.org/index.php?search={searchTerms}";}];
                iconUpdateURL = "https://wiki.nixos.org/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = ["@nw"];
              };

              "Bing".metaData.hidden = true;
              "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
            };
            order = [
              "DuckDuckGo"
              "Google"
            ];
            privateDefault = "DuckDuckGo";
          };
        };
      };
    };
  };
}
