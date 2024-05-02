{ config, lib, pkgs, inputs, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.hyprland;
in {

  options.modules.hyprland.enable =
    mkBoolOpt false;

  imports = [
    ./config.nix
    ./variables.nix
  ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wallust # better pywal
      blueman
      kitty
      grimblast
      waybar
      wofi
      nwg-drawer
      nwg-launchers
      nwg-look
      pavucontrol
      swww
      # xfce.thunar
      # xfce.thunar-volman
      # xfce.thunar-archive-plugin
      # xfce.thunar-media-tags-plugin
      # wayland-egl
      brightnessctl
      hypridle
      hyprlock

      galculator
    ];
  };

}
