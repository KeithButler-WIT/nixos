{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.nemo;
in {

  #TODO: Fix module path
  options.modules.desktop.apps.nemo.enable =
    mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      cinnamon.nemo-with-extensions
    ];
  };

}
