{ config, lib, pkgs, ... }:

{

  programs.kitty = {
    enable = true;
    font = {
      name = "jetbrains mono nerd font";
      package = pkgs.jetbrains-mono;
      size = 12;
    };
    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      mouse_hide_wait = "2.0";
      cursor_shape = "block";
      # url_color = "#0087bd";
      url_style = "dotted";
      confirm_os_window_close = 0;
      background_opacity = "0.95";
      shell = "fish";
    };
    shellIntegration.enableFishIntegration = true;
    theme = "Catppuccin-Mocha";
  };

}
