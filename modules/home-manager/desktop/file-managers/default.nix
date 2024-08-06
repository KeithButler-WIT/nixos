{ self, lib, config, options, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.file-managers;
in {
  options.modules.desktop.file-managers = {
    default = mkOpt (with types; nullOr str) null;
  };

  config = mkIf (cfg.default != null) {
    home.sessionVariables.FILEMANAGER = cfg.default;
  };
}
