{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.gaming.r2modman;
in {

  options.modules.desktop.gaming.r2modman.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      r2modman
    ];
  };

}
