{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.media.ncmpcpp;
in {

  options.modules.media.ncmpcpp.enable =
    mkEnableOption "enables ncmpcpp";

  config = mkIf cfg.enable {
    programs.ncmpcpp = {
      enable = true;
      #mpdMusicDir= "~/Music";
      bindings = [
        { key = "j"; command = "scroll_down"; }
        { key = "k"; command = "scroll_up"; }
        { key = "J"; command = [ "select_item" "scroll_down" ]; }
        { key = "K"; command = [ "select_item" "scroll_up" ]; }
        { key = "v"; command = "show_visualizer"; }
      ];
    };
  };

}
