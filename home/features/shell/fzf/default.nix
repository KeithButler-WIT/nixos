{ config, lib, pkgs, ... }:

{

  programs.fzf = {
    package = pkgs.fzf;
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    # enableZshIntegration = true;
  };

}
