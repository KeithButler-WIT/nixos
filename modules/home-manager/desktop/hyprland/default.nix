{ config, lib, pkgs, inputs, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.hyprland;
in {

  options.modules.desktop.hyprland.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wallust # better pywal
      blueman
      kitty
      grimblast
      waybar
      pavucontrol
      swww
      # wayland-egl
      brightnessctl

      galculator

      tofi
    ];
  };

}
