# https://unity.com

{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.apps.unity;
in
{

  options.modules.desktop.apps.unity = {
    enable = mkBoolOpt false;
    flatpak = mkBoolOpt false;
  };

  config = mkIf (cfg.enable && !cfg.flatpak) {
    home.packages = with pkgs; [
      (unityhub.override {
        extraPkgs = fhsPkgs: [
          fhsPkgs.harfbuzz
          fhsPkgs.libogg
        ];
      })
    ];
  };

}
