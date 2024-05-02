{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.fzf;
in {

  options.modules.shell.fzf.enable =
    mkBoolOpt false;

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
