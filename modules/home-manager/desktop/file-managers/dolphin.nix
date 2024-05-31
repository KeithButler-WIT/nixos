{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.dolphin;
in {

  #TODO: Fix module path
  options.modules.desktop.apps.dolphin.enable =
    mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.dolphin
    ];
  };

}
