{ config, pkgs, ... }:

{
  home.username = "<username>";
  home.homeDirectory = "/home/<username>";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
