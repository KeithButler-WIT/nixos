{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.apps.godot;
in {
  options.modules.desktop.apps.godot.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # aseprite
      godot
      godot-export-templates-bin
      gdtoolkit_4
    ];
  };
}
