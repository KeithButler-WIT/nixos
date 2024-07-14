{ config, lib, pkgs, inputs, userSettings, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.eww;
in
{

  options.modules.desktop.eww.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];

    programs.eww = {
      enable = true;
      configDir = ./eww;
    };
  };

}
