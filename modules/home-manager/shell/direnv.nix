{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.direnv;
in {

  options.modules.shell.direnv.enable =
    mkEnableOption "enables direnv";

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;

      # enableFishIntegration = true;
      # enableBashIntegration = true;
      # enableNushellIntegration = true;
      # enableZshIntegration = true;
    };
  };

}
