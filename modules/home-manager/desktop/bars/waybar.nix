{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.bars.waybar;
in {

  options.modules.desktop.bars.waybar = {
    enable = mkBoolOpt false;
    horizontal = mkBoolOpt false;
    vertical = mkBoolOpt false;
  };

  config = mkIf cfg.enable (mkMerge [
    { 
      programs.waybar = {
        enable = true;
        systemd.enable = true;
      };
    }

    (mkIf (cfg.horizontal&& !cfg.vertical) {
      # TODO: add horizontal config
    })

    (mkIf (cfg.vertical&& !cfg.horizontal) {
      home.file.".config/waybar" = {
        source = ./waybar;
        recursive = true;
      };
    })

  ]);

}
