{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.zoom;
in {

  options.modules.desktop.apps.zoom.enable =
    mkEnableOption "enables zoom";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zoom-us
    ];
  };

}
