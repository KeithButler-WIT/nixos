{
  lib,
  config,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.term;
in
{
  options.modules.desktop.term = {
    default = mkOpt (with types; nullOr str) null;
  };

  config = mkIf (cfg.default != null) {
    home.sessionVariables.TERMINAL = cfg.default;
    home.sessionVariables.TERMINAL_PROG = cfg.default;
  };
}
