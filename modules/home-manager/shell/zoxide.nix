{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.shell.zoxide;
in
{

  options.modules.shell.zoxide.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
  };

}
