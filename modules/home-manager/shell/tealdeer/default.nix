{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.tealdeer;
in {

  options.modules.shell.tealdeer.enable =
    mkEnableOption "enables tealdeer";

  config = mkIf cfg.enable {
    programs.tealdeer = {
      enable = true;
      settings = {
        style.description = {
          underline = false;
          bold = false;
          italic = false;
        };

        style.command_name = {
          foreground = "cyan";
          underline = false;
          bold = false;
          italic = false;
        };

        style.example_text = {
          foreground = "green";
          underline = false;
          bold = false;
          italic = false;
        };

        style.example_code = {
          foreground = "cyan";
          underline = false;
          bold = false;
          italic = false;
        };

        style.example_variable = {
          foreground = "cyan";
          underline = true;
          bold = false;
          italic = false;
        };

        display = {
          compact = false;
          use_pager = false;
        };

        updates = {
          auto_update = true;
          auto_update_interval_hours = 720;
        };

        directories = { };
      };
    };
  };

}
