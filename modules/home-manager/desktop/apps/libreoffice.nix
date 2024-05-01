{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.libreoffice;
in {

  options.modules.desktop.apps.libreoffice.enable =
    mkEnableOption "enables libreoffice";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice
    ];
  };

}
