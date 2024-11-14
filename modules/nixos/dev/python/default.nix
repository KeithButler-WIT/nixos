{ pkgs, config, lib, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.python;
in {

  options.modules.dev.python.enable =
    mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (python3.withPackages (ps: with ps; [ types-beautifulsoup4 beautifulsoup4 wxpython]))
    ];
  };

}
