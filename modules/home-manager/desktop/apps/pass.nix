{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.pass;
in {

  options.modules.desktop.apps.pass.enable =
    mkEnableOption "enables keepassxc and pass";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      keepassxc
      pass
    ];
  };

}
