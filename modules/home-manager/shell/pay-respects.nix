{
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.shell.pay-respects;
in {
  options.modules.shell.pay-respects.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.pay-respects = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
  };
}
