{ config, lib, pkgs, inputs, userSettings, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.tofi;
in
{

  options.modules.desktop.tofi.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.tofi = {
      enable = true;
      settings = {
        width = "40%";
        height = "30%";
        border-width = 1;
        outline-width = 1;
        padding-left = "0%";
        padding-top = "0%";
        result-spacing = 25;
        num-results = 5;
        # font = "monospace";
        # background-color = "#000A";
      };
    };

    home.file.".config/tofi/themes/soy-milk".text = ''
      # Font
      font = Fredoka One
      font-size = 20

      # Window Style
      horizontal = true
      anchor = top
      width = 100%
      height = 48

      outline-width = 0
      border-width = 0
      min-input-width = 120
      result-spacing = 30
      padding-top = 8
      padding-bottom = 0
      padding-left = 20
      padding-right = 0

      # Text style
      prompt-text = "Can I have a"
      prompt-padding = 30

      background-color = #fff0dc
      text-color = #4280a0

      prompt-background = #eebab1
      prompt-background-padding = 4, 10
      prompt-background-corner-radius = 12

      input-color = #e1666a
      input-background = #f4cf42
      input-background-padding = 4, 10
      input-background-corner-radius = 12

      alternate-result-background = #b8daf3
      alternate-result-background-padding = 4, 10
      alternate-result-background-corner-radius = 12

      selection-color = #f0d2af
      selection-background = #da5d64
      selection-background-padding = 4, 10
      selection-background-corner-radius = 12
      selection-match-color = #fff

      clip-to-padding = false
    '';

    home.file.".config/tofi/themes/fullscreen".text = ''
      width = 100%
      height = 100%
      border-width = 0
      outline-width = 0
      padding-left = 35%
      padding-top = 35%
      result-spacing = 25
      num-results = 5
      font = monospace
      background-color = #000A
    '';
  };

}
