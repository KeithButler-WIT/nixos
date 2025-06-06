{
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.shell.thefuck;
in {
  options.modules.shell.thefuck.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.thefuck = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
