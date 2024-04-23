{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.browsers.qutebrowser;
in {

  options.modules.browsers.qutebrowser.enable =
    mkEnableOption "enables qutebrowser";

  config = mkIf cfg.enable {
    programs.qutebrowser = with config.colorScheme.palette; {
      enable = true;
      settings = {
        colors = {
          hints = {
            bg = "#000000";
            fg = "#ffffff";
          };
          tabs.bar.bg = "#000000";
        };
        tabs.tabs_are_windows = false;
      };
    };
    # quickmarks = {
    #   humblebundle = "https://www.humblebundle.com";
    #   chatgpt= "https://chat.openai.com";
    #   nixpkgs = "https://github.com/NixOS/nixpkgs";
    #   home-manager = "https://github.com/nix-community/home-manager";
    # };
  };

}
