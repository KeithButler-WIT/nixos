{ config, lib, pkgs, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.fish;
in {

  options.modules.shell.fish.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.zoxide
      pkgs.curl
      pkgs.man
      #pkgs.starship
      pkgs.bat
      pkgs.mcfly
    ];

    programs.fish = {
      enable = true;

      functions = {
        gitignore = "${pkgs.curl}/bin/curl -sL https://www.gitignore.io/api/$argv";
        #   yy = ''
        #     	set tmp (mktemp -t "yazi-cwd.XXXXXX")
        #     	yazi $argv --cwd-file="$tmp"
        #     	if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        #     		cd -- "$cwd"
        #     	end
        #     	rm -f -- "$tmp"
        #   '';
      };

      shellInit = ''
        # Hide welcome message
        set fish_greeting
        set VIRTUAL_ENV_DISABLE_PROMPT "1"
        set -x MANPAGER "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'"

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
              if not contains -- ~/.config/emacs/bin $PATH
                    set -p PATH ~/.config/emacs/bin
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
        #if test -f /home/${userSettings.username}/miniconda3/bin/conda
        #      eval /home/${userSettings.username}/miniconda3/bin/conda "shell.fish" "hook" $argv | source
        #end
        # <<< conda initialize <<<

      '';

      loginShellInit = ''
    '';

      interactiveShellInit = ''
        ## Run fastfetch if session is interactive
        # if status --is-interactive && type -q fastfetch
              # ${pkgs.fastfetch}/bin/fastfetch --load-config neofetch
        # end

        #source ("starship" init fish --print-full-init | psub)

        ${pkgs.zoxide}/bin/zoxide init fish | source
        alias cd "z" # Temp fix
        alias cdi "zi" # Temp fix
      '';

      plugins = [
        # Enable a plugin (here grc for colorized command output) from nixpkgs
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
        # Manually packaging and enable a plugin

      ];

      shellAliases = { };
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
  };

}
