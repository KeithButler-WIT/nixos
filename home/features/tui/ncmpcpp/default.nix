{ config, lib, pkgs, ... }:

{

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

}
