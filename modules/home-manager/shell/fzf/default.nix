{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.shell.fzf;
in {

  options.modules.shell.fzf.enable =
    mkEnableOption "enables fzf";

  config = mkIf cfg.enable {
    programs.fzf = {
      package = pkgs.fzf;
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      # enableZshIntegration = true;
    };
  };

}
