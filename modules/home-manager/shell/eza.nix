{ config, lib, pkgs, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.eza;
in {

  options.modules.shell.eza.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      git = true;
      icons = "auto";
    };
  };

}
