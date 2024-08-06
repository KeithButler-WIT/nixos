# https://unrealengine.com

{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.ue;
in {

  options.modules.desktop.apps.ue.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ue4
    ];
  };

}
