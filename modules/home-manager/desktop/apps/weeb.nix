{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.apps.weeb;
in {

  options.modules.desktop.apps.weeb.enable =
    mkEnableOption "enables weeb stuff";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ani-cli
      mangal
      suwayomi-server
    ];
  };

}
