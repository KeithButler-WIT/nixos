{ config, lib, pkgs, ... }:

{

    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;

        # enableFishIntegration = true;
        # enableBashIntegration = true;
        # enableNushellIntegration = true;
        # enableZshIntegration = true;
    };

}
