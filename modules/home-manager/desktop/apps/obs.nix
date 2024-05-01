{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.obs;
in {

  options.modules.desktop.apps.obs.enable =
    mkEnableOption "enables obs";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      obs-studio
    ];
  };

}
