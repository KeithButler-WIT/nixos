{
  self,
  lib,
  config,
  options,
  pkgs,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.browsers;
in
{
  options.modules.desktop.browsers = {
    default = mkOpt (with types; nullOr str) null;
  };

  config = mkIf (cfg.default != null) {
    home.sessionVariables.BROWSER = cfg.default;
  };
}
