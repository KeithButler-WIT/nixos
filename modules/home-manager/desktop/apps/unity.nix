{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.apps.unity;
in {

  options.modules.desktop.apps.unity.enable =
    mkEnableOption "enables unity";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      unityhub
    ];
  };

}
