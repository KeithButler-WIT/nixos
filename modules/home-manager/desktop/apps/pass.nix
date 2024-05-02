{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.pass;
in {

  options.modules.desktop.apps.pass.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      keepassxc
      pass
    ];
  };

}
