{
  pkgs,
  config,
  lib,
  userSettings,
  ...
}:
with lib;
with lib.my;
let
  devCfg = config.modules.dev;
  cfg = devCfg.shell;
in
{
  options.modules.dev.shell = {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      users.users.${userSettings.username}.packages = with pkgs; [
        shellcheck
      ];
    })

    (mkIf cfg.xdg.enable {
      # TODO
    })
  ];
}
