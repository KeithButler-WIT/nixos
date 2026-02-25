{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.my;
let
  cfg = config.modules.desktop.browsers.zen;
in
{
  options.modules.desktop.browsers.zen.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      inputs.zen-browser.packages."${system}".default
    ];

    xdg.mimeApps =
      let
        value =
          let
            zen-browser = inputs.zen-browser.packages.${system}.beta; # or twilight
          in
          zen-browser.meta.desktopFileName;

        associations = builtins.listToAttrs (
          map
            (name: {
              inherit name value;
            })
            [
              "application/x-extension-shtml"
              "application/x-extension-xhtml"
              "application/x-extension-html"
              "application/x-extension-xht"
              "application/x-extension-htm"
              "x-scheme-handler/unknown"
              "x-scheme-handler/mailto"
              "x-scheme-handler/chrome"
              "x-scheme-handler/about"
              "x-scheme-handler/https"
              "x-scheme-handler/http"
              "application/xhtml+xml"
              "application/json"
              "text/plain"
              "text/html"
            ]
        );
      in
      {
        associations.added = associations;
        defaultApplications = associations;
      };

  };
}
