{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.apps.signal;
in {

  options.modules.desktop.apps.signal.enable =
    mkEnableOption "enables signal";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      signal-desktop
    ];
  };

}
