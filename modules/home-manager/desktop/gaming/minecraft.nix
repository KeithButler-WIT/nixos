{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.gaming.minecraft;
in {

  options.modules.desktop.gaming.minecraft.enable =
    mkEnableOption "enables minecraft";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };

}
