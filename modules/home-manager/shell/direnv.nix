{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.direnv;
in {

  options.modules.shell.direnv.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      # enableFishIntegration = true; # defaults to true
      enableBashIntegration = true;
      enableNushellIntegration = true;
      # enableZshIntegration = true;
    };
  };

}
