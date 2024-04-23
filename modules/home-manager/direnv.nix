{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.direnv;
in {

  options.modules.direnv.enable =
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
