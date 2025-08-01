{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.browsers.zen;
in {
  options.modules.desktop.browsers.zen.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      inputs.zen-browser.packages."${system}".default
    ];
  };
}
