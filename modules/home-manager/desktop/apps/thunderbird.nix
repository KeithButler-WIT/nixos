{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.apps.thunderbird;
in {

  options.modules.desktop.apps.thunderbird.enable =
    mkEnableOption "enables thunderbird";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      thunderbird
    ];
  };

}
