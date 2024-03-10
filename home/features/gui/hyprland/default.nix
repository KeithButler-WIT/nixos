{ config, lib, pkgs, inputs, userSettings, ... }:

{

  imports = [
    ./config.nix
    ./variables.nix
  ];

  home.packages = [
    pkgs.blueman
    pkgs.kitty
    pkgs.grimblast
    pkgs.waybar
    pkgs.wofi
    pkgs.nwg-drawer
    pkgs.nwg-launchers
    pkgs.nwg-look
    pkgs.pavucontrol
    pkgs.swaylock
    pkgs.swww
    pkgs.xfce.thunar
    pkgs.xfce.thunar-volman
    pkgs.xfce.thunar-archive-plugin
    pkgs.xfce.thunar-media-tags-plugin
    # pkgs.wayland-egl
  ];


}
