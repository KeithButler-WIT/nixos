{
  pkgs,
  config,
  lib,
  userSettings,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.browsers.firefox;
in {
  options.modules.desktop.browsers.firefox.enable = mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    stylix.targets.firefox.profileNames = ["${userSettings.username}"];
    programs.firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DisableSetDesktopBackground = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          OfferToSaveLoginsDefault = false;
          PasswordManagerEnabled = false;
          DontCheckDefaultBrowser = true;
          FirefoxHome = {
            Search = true;
            Pocket = false;
            Snippets = false;
            TopSites = false;
            Highlights = false;
          };
          UserMessaging = {
            ExtensionRecommendations = false;
            SkipOnboarding = true;
          };
          ExtensionSettings = {};
        };
      };
      profiles.${userSettings.username} = {
        id = 0;
        isDefault = true;
        name = userSettings.username;
        search = {
          force = true;
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
              definedAliases = ["@n"];
            };
            "Flathub" = {
              urls = [
                {
                  template = "https://flathub.org/apps/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [
                "@flathub"
                "@fh"
              ];
            };
          };
        };
        settings = {
          "general.smoothScroll" = true;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        #   keepassxc-browser
        #   libredirect
        #   ublock-origin
        #   sponsorblock
        #   augmented-steam
        #   protondb-for-steam
        #   youtube-shorts-block
        #   firemonkey
        # ];
        # modified theme from https://github.com/Bali10050/FirefoxCSS
        userChrome = builtins.readFile ./userChrome.css;
        userContent = builtins.readFile ./userContent.css;
      };
    };
  };
}
