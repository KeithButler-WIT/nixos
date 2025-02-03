{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.vr;
in {
  options.modules.desktop.vr.enable = mkBoolOpt false;

  config =
    lib.mkIf cfg.enable {
    };
}
