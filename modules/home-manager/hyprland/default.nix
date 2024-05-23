{ config, lib, pkgs, inputs, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.hyprland;
in {

  options.modules.hyprland.enable =
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
      hypridle
      hyprlock

      galculator

      tofi
    ];
  };

}
