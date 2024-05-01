{ config, lib, pkgs, ... }:

with lib;
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
