{
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.gc;
in {
  options.modules.gc.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    nix = {
      settings.auto-optimise-store = true;
      gc = {
        automatic = true;
        persistent = true;
        frequency = "weekly";
        randomizedDelaySec = "45min";
        #options = "--max-freed $((64 * 1024**3)) --delete-older-than 7d";
      };
    };
  };
}
