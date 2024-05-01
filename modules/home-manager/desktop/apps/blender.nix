{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.blender;
in {

  options.modules.desktop.apps.blender.enable =
    mkEnableOption "enables blender";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      blender
    ];
  };

}
