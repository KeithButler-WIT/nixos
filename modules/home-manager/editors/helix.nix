{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.helix;
in {

  options.modules.editors.helix.enable =
    mkBoolOpt false;

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
        # language-server = {
        # typescript-language-server = with pkgs.nodePackages; {
        #   command = "${typescript-language-server}/bin/typescript-language-server";
        #   args = [ "--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib" ];
        # };
        # };

        language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
          }
          {
            name = "rust";
            auto-format = true;
          }
          {
            name = "gdscript";
            auto-format = true;
          }
          {
            name = "python";
            auto-format = true;
          }
          {
            name = "bash";
            auto-format = true;
          }
          {
            name = "c++";
            auto-format = true;
          }
        ];
      };
    };
  };

}
