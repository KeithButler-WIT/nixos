{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.editors.helix;
in {
  options.modules.editors.helix.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      # package = pkgs.evil-helix;
      settings = {
        editor = {
          line-number = "relative";
          cursorline = true;
          bufferline = "multiple";
          color-modes = true;
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          indent-guides = {
            render = true;
          };
        };
      };
      languages = {
        language-server = {
          cmake-language-server = with pkgs; {
            command = "${cmake-language-server}/bin/cmake-language-server";
            args = [];
          };
          yaml-language-server = with pkgs; {
            command = "${yaml-language-server}/bin/yaml-language-server";
            args = [];
          };
        };

        language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
            file-types = ["nix"];
            scope = "source.nix";
          }
          {
            name = "rust";
            auto-format = true;
            file-types = ["rs"];
            scope = "source.rs";
          }
          {
            name = "python";
            auto-format = true;
            file-types = ["py"];
            scope = "source.py";
          }
          {
            name = "bash";
            auto-format = true;
            file-types = ["sh"];
            scope = "source.sh";
          }
          {
            name = "c++";
            auto-format = true;
            file-types = ["cpp"];
            scope = "source.cpp";
          }
          {
            name = "cmake";
            auto-format = true;
            scope = "source.cmake";
          }
        ];
      };
    };
  };
}
