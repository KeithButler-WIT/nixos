{ config, lib, pkgs, ... }:

{

  programs.ssh = {
    enable = true;
    matchBlocks."github.com" = {
      user = "git";
      identityFile = "~/.ssh/id_ed25519";
    };
    extraConfig = ''
    '';
  };

}
