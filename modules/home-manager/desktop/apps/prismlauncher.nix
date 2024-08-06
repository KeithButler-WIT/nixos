{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.prismlauncher;
in {

  options.modules.desktop.apps.prismlauncher.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };

}
