{
  config,
  lib,
  ...
}:
with lib;
with lib.my;
let
  cfg = config.modules.zfs;
in
{
  options.modules.zfs.enable = mkBoolOpt false;

  config = lib.mkIf cfg.enable {
  };
}
