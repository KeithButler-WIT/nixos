{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.bitwarden;
in {

  #TODO: Fix module path
  options.modules.desktop.apps.bitwarden.enable =
    mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bitwarden
      bitwarden-cli
    ];
  };

}
