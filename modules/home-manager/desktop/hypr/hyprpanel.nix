{
  config,
  lib,
  inputs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.bars.hyprpanel;
in {
  options.modules.desktop.bars.hyprpanel.enable = mkBoolOpt false;

  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
  ];

  config = mkIf cfg.enable {
    programs.hyprpanel = {
      # Enable the module.
      # Default: false
      enable = true;

      # Automatically restart HyprPanel with systemd.
      # Useful when updating your config so that you
      # don't need to manually restart it.
      # Default: false
      systemd.enable = true;

      # Add '/nix/store/.../hyprpanel' to your
      # Hyprland config 'exec-once'.
      # Default: false
      hyprland.enable = true;
    };
  };
}
