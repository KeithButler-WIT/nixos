{ config, lib, pkgs, ... }:

{

  home.packages = [
        pkgs.zoxide
        pkgs.curl
        pkgs.man
        pkgs.starship
        pkgs.bat
  ];

  programs.fish = {
    enable = true;

    functions = {
      gitignore = "${pkgs.curl}/bin/curl -sL https://www.gitignore.io/api/$argv";
    };

    shellInit = ''
      # Hide welcome message
      set fish_greeting
      set VIRTUAL_ENV_DISABLE_PROMPT "1"
      set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

      ## Export variable need for qt-theme
      if type "qtile" >> /dev/null 2>&1
            set -x QT_QPA_PLATFORMTHEME "qt5ct"
      end

      # Set settings for https://github.com/franciscolourenco/done
      set -U __done_min_cmd_duration 10000
      set -U __done_notification_urgency_level low

      ## Environment setup
      # Apply .profile: use this to put fish compatible .profile stuff in
      if test -f ~/.fish_profile
            source ~/.fish_profile
      end

      # Add ~/.local/bin to PATH
      if test -d ~/.local/bin
            if not contains -- ~/.local/bin $PATH
                  set -p PATH ~/.local/bin
            end
      end

      # Add depot_tools to PATH
      if test -d ~/Applications/depot_tools
            if not contains -- ~/Applications/depot_tools $PATH
                  set -p PATH ~/Applications/depot_tools
            end
      end

      # Add ~/.config/.emacs.d/bin  to PATH
      if test -d ~/.config/emacs/bin
            if not contains -- ~/.config/.emacs.d/bin $PATH
                  set -p PATH ~/.config/.emacs.d/bin
            end
      end

      # Add ~/.cargo/bin  to PATH
      if test -d ~/.cargo/bin
            if not contains -- ~/.cargo/bin $PATH
                  set -p PATH ~/.cargo/bin
            end
      end

      ## Advanced command-not-found hook
      source /usr/share/doc/find-the-command/ftc.fish


      ## Run fastfetch if session is interactive
      # if status --is-interactive && type -q fastfetch
            # ${pkgs.fastfetch}/bin/fastfetch --load-config neofetch
      # end

      ${pkgs.macchina}/bin/macchina -t Berylilum
      # ${pkgs.macchina}/bin/macchina -t Helium
      # ${pkgs.macchina}/bin/macchina -t Hydrogen
      # ${pkgs.macchina}/bin/macchina -t Lithium


      if [ "$INSIDE_EMACS" = 'vterm' ]
            function clear
                  vterm_printf "51;Evterm-clear-scrollback";
                  tput clear;
            end
      end

      ${pkgs.zoxide}/bin/zoxide init fish | source


      # if [ "$fish_key_bindings" = fish_vi_key_bindings ];
      #       bind -Minsert ! __history_previous_command
      #       bind -Minsert '$' __history_previous_command_arguments
      # else
      #       bind ! __history_previous_command
      #       bind '$' __history_previous_command_arguments
      # end

      set -g direnv_fish_mode eval_on_arrow    # trigger direnv at prompt, and on every arrow-based directory change (default)

      # >>> conda initialize >>>
      # !! Contents within this block are managed by 'conda init' !!
      #if test -f /home/keith/miniconda3/bin/conda
      #      eval /home/keith/miniconda3/bin/conda "shell.fish" "hook" $argv | source
      #end
      # <<< conda initialize <<<

    '';

    loginShellInit = ''
    '';

    interactiveShellInit = ''
      source ("starship" init fish --print-full-init | psub)
    '';

    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      # { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      # Manually packaging and enable a plugin
    ];

    shellAliases = {
    };
  };

  home.file.".config/macchina/themes/Berylilum.toml".text = ''
      # Beryllium
      # https://github.com/Macchina-CLI/macchina/blob/main/contrib/themes/Beryllium.toml

      spacing         = 3
      hide_ascii      = true
      key_color       = "#7067CF"
      separator       = ""

      [box]
      border          = "plain"
      visible         = true

      [palette]
      glyph           = "○  "
      visible         = true

      [bar]
      glyph           = "○"
      hide_delimiters = true
      visible         = true

      [box.inner_margin]
      x               = 2
      y               = 1

      [custom_ascii]
      color           = "#FF7001"
  '';

}
