{ config, lib, pkgs, ... }:

{
  programs.qutebrowser = with config.colorScheme.colors; {
    enable = false;
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
}
