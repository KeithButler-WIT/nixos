{ config, lib, pkgs, ... }:

{

  home.packages = [
      pkgs.gamemode
      #pkgs.heroic
      pkgs.protonup-ng
      pkgs.protonup-qt
      #pkgs.proton-ge
      pkgs.winetricks
      pkgs.protontricks
      #pkgs.wine-staging
      #pkgs.wine-osu
      #pkgs.wine-tkg
      # (pkgs.openmw.overrideAttrs (_: rec { dontWrapQtApps = false; }))
      # pkgs.openmw
  ];

}
