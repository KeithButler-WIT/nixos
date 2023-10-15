{ config, pkgs, ... }:

{
  home.username = "keith";
  home.homeDirectory = "/home/keith";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
