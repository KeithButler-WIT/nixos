{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.thunderbird;
in {

  options.modules.desktop.apps.thunderbird.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      thunderbird
    ];

    home.sessionVariables.MAIL = "thunderbird";
  };

}
