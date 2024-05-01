{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.godot;
in {

  options.modules.desktop.apps.godot.enable =
    mkEnableOption "enables godot";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      aseprite
      godot_4
    ];
  };

}
