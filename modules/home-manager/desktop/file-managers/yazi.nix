{ pkgs, config, lib, inputs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.apps.yazi;
  plugins-repo = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "06e5fe1c7a2a4009c483b28b298700590e7b6784";
    sha256 = "sha256-jg8+GDsHOSIh8QPYxCvMde1c1D9M78El0PljSerkLQc=";
  };
in
{

  #TODO: Fix module path
  options.modules.desktop.apps.yazi.enable =
    mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ffmpegthumbnailer
      unar
      jq
      poppler
      fd
      ripgrep
      fzf
      zoxide # TODO: if zoxide module enabled
      wl-clipboard
    ];

    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      package = inputs.yazi.packages.${pkgs.system}.default;
      shellWrapperName = "y";

      plugins = {
        chmod = "${plugins-repo}/chmod.yazi";
        full-border = "${plugins-repo}/full-border.yazi";
        starship = pkgs.fetchFromGitHub {
          owner = "Rolv-Apneseth";
          repo = "starship.yazi";
          rev = "0a141f6dd80a4f9f53af8d52a5802c69f5b4b618";
          sha256 = "sha256-OL4kSDa1BuPPg9N8QuMtl+MV/S24qk5R1PbO0jgq2rA=";
        };
      };

      initLua = ''
        			require("full-border"):setup()
        			require("starship"):setup()
      '';

      settings = {
        manager = {
          sort_by = "natural";
          # show_hidden = true;
          # show_symlink = true;
        };

        # preview = {
        #   image_filter = "lanczos3";
        #   image_quality = 80;
        #   max_width = 600;
        #   max_height = 900;
        #   ueberzug_scale = 1;
        #   ueberzug_offset = [ 0 0 0 0 ];
        # };

        # tasks = {
        #   micro_workers = 5;
        #   macro_workers = 10;
        #   bizarre_retry = 5;
        # };

        #   open = {
        #     rules = [
        #       {
        #         use = "open";
        #         mime = "image/*";
        #       }
        #       {
        #         use = [ "play" "reveal" ];
        #         mime = "video/*";
        #       }
        #       {
        #         use = [ "play" "reveal" ];
        #         mime = "audio/*";
        #       }
        #     ];
        #   };

        #   opener = {
        #     edit = [
        #       {
        #         run = "nvim \"$@\"";
        #         block = true;
        #         for = "unix";
        #       }
        #     ];
        #     open = [
        #       {
        #         run = "qimgv \"$@\"";
        #         desc = "Open";
        #       }
        #     ];
        #     reveal = [
        #       {
        #         run = "''${pkgs.exiftool}/bin/exiftool \"$1\"; echo \"Press enter to exit\"; read _''";
        #         block = true;
        #         desc = "Show EXIF";
        #       }
        #     ];
        #     play = [
        #       {
        #         run = "mpv \"$@\"";
        #         orphan = true;
        #       }
        #       {
        #         run = "''${pkgs.mediainfo}/bin/mediainfo \"$1\"; echo \"Press enter to exit\"; read _''";
        #         block = true;
        #         desc = "Show media info";
        #       }
        #     ];
        #     archive = [
        #       {
        #         run = "unar \"$1\"";
        #         desc = "Extract here";
        #       }
        #     ];
        #   };
      };

      # keymap = {
      #   manager.keymap = [
      #     {
      #       run = "shell 'dragon -x -i -T \"$1\"'";
      #       on = [ "<C-d>" ];
      #       desc = "Open file in dragon";
      #     }
      #   ];
      # };

    };
  };

}
