{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.file-managers.yazi;
  plugins-repo = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "06e5fe1c7a2a4009c483b28b298700590e7b6784";
    sha256 = "sha256-jg8+GDsHOSIh8QPYxCvMde1c1D9M78El0PljSerkLQc=";
  };
in {
  options.modules.desktop.file-managers.yazi.enable = mkBoolOpt false;

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
      mediainfo
    ];

    # home.file.".config/yazi" = {
    #   source = ./yazi;
    #   recursive = true;
    # };

    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      package = inputs.yazi.packages.${pkgs.system}.default;
      shellWrapperName = "y";

      plugins = {
        git = pkgs.yaziPlugins.git;
        rsync = pkgs.yaziPlugins.rsync;
        mount = pkgs.yaziPlugins.mount;
        chmod = pkgs.yaziPlugins.chmod;
        lazygit = pkgs.yaziPlugins.lazygit;
        mediainfo = pkgs.yaziPlugins.mediainfo;
        starship = pkgs.yaziPlugins.starship;
      };

      # TODO: Convert from toml file
      keymap = {
        mgr.prepend_keymap = [
          {
            run = "shell 'dragon-drop -x -i -T \"$1\"' --confirm";
            on = ["<C-t>"];
            desc = "Open shell here";
          }
        ];
      };

      settings = {
        mgr = {
          sort_by = "natural";
          # show_hidden = true;
          # show_symlink = true;
        };
      };
      theme = {
        filetype = {
          rules = [
            {
              fg = "#7AD9E5";
              mime = "image/*";
            }
            {
              fg = "#F3D398";
              mime = "video/*";
            }
            {
              fg = "#F3D398";
              mime = "audio/*";
            }
            {
              fg = "#CD9EFC";
              mime = "application/bzip";
            }
          ];
        };
      };
    };
  };
}
