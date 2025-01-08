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
  cfg = config.modules.editors;
in
{
  options.modules.editors = {
    default = mkOpt (with types; nullOr str) null;
    alternate = mkOpt (with types; nullOr str) null;
  };

  config = mkIf (cfg.default != null) {
    home.sessionVariables.EDITOR = cfg.default;
    home.sessionVariables.ALTERNATE_EDITOR = cfg.alternate;
  };
}
