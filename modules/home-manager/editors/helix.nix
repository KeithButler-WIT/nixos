{
  pkgs,
  config,
  lib,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.editors.helix;
in
{

  options.modules.editors.helix.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      settings = {
        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      languages = {
        # the language-server option currently requires helix from the master branch at https://github.com/helix-editor/helix/
        language-server = {
          # typescript-language-server = with pkgs.nodePackages; {
          #   command = "${typescript-language-server}/bin/typescript-language-server";
          #   args = [ "--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib" ];
          # };
          haskell-language-server = with pkgs.haskellPackages; {
            command = "${haskell-language-server}/bin/haskell-language-server";
            args = [ ];
          };
          gdscript-language-server = with pkgs; {
            command = "${gdtoolkit}/bin/gdtoolkit";
            args = [ ];
          };
          cmake-language-server = with pkgs; {
            command = "${cmake-language-server}/bin/cmake-language-server";
            args = [ ];
          };
          yaml-language-server = with pkgs; {
            command = "${yaml-language-server}/bin/yaml-language-server";
            args = [ ];
          };
        };

        language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
            file-types = [ "nix" ];
            scope = "source.nix";

          }
          {
            name = "rust";
            auto-format = true;
            file-types = [ "rs" ];
            scope = "source.rs";
          }
          {
            name = "gdscript";
            auto-format = true;
            formatter.command = "${pkgs.gdtoolkit}/bin/gdformat";
            file-types = [ "gd" ];
            scope = "source.gd";
          }
          {
            name = "python";
            auto-format = true;
            file-types = [ "py" ];
            scope = "source.py";
          }
          {
            name = "bash";
            auto-format = true;
            file-types = [ "sh" ];
            scope = "source.sh";
          }
          {
            name = "c++";
            auto-format = true;
            file-types = [ "cpp" ];
            scope = "source.cpp";
          }
          {
            name = "haskell";
            auto-format = true;
            file-types = [ "hs" ];
            scope = "source.hs";
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
