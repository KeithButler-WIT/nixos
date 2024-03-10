{ config, lib, pkgs, ... }:

{

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      # name = "jetbrains mono nerd font";
      # package = pkgs.jetbrains-mono;
      size = 12;
    };
    settings = {
      shell = "fish";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      cursor_shape = "block";
      # url_color = "#0087bd";
      url_style = "dotted";
      confirm_os_window_close = 0;
      background_opacity = "0.95";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      mouse_hide_wait = 60;
    };
    shellIntegration.enableFishIntegration = true;
    theme = "Catppuccin-Mocha";
  };

}
