{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.ags;
in {

  options.modules.desktop.ags = {
    enable = mkBoolOpt false;
    horizontal.enable = mkBoolOpt false;
    vertical.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable (mkMerge [
    { }

    (mkIf (cfg.enable) {
      home.packages = with pkgs; [
        ags
        bun
      ];

    })

  ]);

}
