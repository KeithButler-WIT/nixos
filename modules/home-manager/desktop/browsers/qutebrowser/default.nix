{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.browsers.qutebrowser;
in {

  options.modules.desktop.browsers.qutebrowser.enable =
    mkBoolOpt false;

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
