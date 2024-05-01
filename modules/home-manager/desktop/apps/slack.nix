{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.apps.slack;
in {

  options.modules.desktop.apps.slack.enable =
    mkEnableOption "enables slack";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      slack
    ];
  };

}
