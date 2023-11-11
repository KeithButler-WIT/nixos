{ config, lib, pkgs, ... }:

{

  programs.fish = {
    enable = true;

    functions = {
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
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

      ## Starship prompt
      if status --is-interactive
            source ("/usr/bin/starship" init fish --print-full-init | psub)
      end


      ## Advanced command-not-found hook
      source /usr/share/doc/find-the-command/ftc.fish


      ## Run fastfetch if session is interactive
      if status --is-interactive && type -q fastfetch
            fastfetch --load-config neofetch
      end


      if [ "$INSIDE_EMACS" = 'vterm' ]
            function clear
                  vterm_printf "51;Evterm-clear-scrollback";
                  tput clear;
            end
      end


      if [ "$fish_key_bindings" = fish_vi_key_bindings ];
            bind -Minsert ! __history_previous_command
            bind -Minsert '$' __history_previous_command_arguments
      else
            bind ! __history_previous_command
            bind '$' __history_previous_command_arguments
      end

      set -g direnv_fish_mode eval_on_arrow    # trigger direnv at prompt, and on every arrow-based directory change (default)

      # >>> conda initialize >>>
      # !! Contents within this block are managed by 'conda init' !!
      if test -f /home/keith/miniconda3/bin/conda
            eval /home/keith/miniconda3/bin/conda "shell.fish" "hook" $argv | source
      end
      # <<< conda initialize <<<

    '';

    loginShellInit = ''
    '';

    interactiveShellInit = ''
    '';

    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      # { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      # Manually packaging and enable a plugin
    ];

    shellAliases = {
      # Replace ls with exa
      ls="exa -al --color=always --group-directories-first --icons"; # preferred listing
      la="exa -a --color=always --group-directories-first --icons";  # all files and dirs
      ll="exa -l --color=always --group-directories-first --icons";  # long format
      lt="exa -aT --color=always --group-directories-first --icons"; # tree listing
      "l."="exa -a | grep -E '^\.'";                                   # show only dotfiles
      ip="ip -color";

      # Replace some more things with better alternatives
      cat="bat --style header --style snip --style changes --style header";
      yay="paru";

      # Common use
      grubup="sudo update-grub";
      fixpacman="sudo rm /var/lib/pacman/db.lck";
      tarnow="tar -acf ";
      untar="tar -xvf ";
      wget="wget -c ";
      rmpkg="sudo pacman -Rdd";
      psmem="ps auxf | sort -nr -k 4";
      psmem10="ps auxf | sort -nr -k 4 | head -10";
      upd="/usr/bin/garuda-update";
      cl="clear";
      ".."="cd ..";
      "..."="cd ../..";
      "...."="cd ../../..";
      "....."="cd ../../../..";
      "......"="cd ../../../../..";
      dir="dir --color=auto";
      vdir="vdir --color=auto";
      grep="grep --color=auto";
      fgrep="fgrep --color=auto";
      egrep="egrep --color=auto";
      hw="hwinfo --short";                          # Hardware Info
      big="expac -H M '%m\t%n' | sort -h | nl";     # Sort installed packages according to size in MB
      gitpkg="pacman -Q | grep -i '\-git' | wc -l"; # List amount of -git packages
      hm="home-manager";
      hms="home-manager switch --impure";

      # Get fastest mirrors
      mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist";
      mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist";
      mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist";
      mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist";

      # Cleanup orphaned packages
      cleanup="sudo pacman -Rns (pacman -Qtdq)";
      nixclean="home-manager expire-generations 10; nix-store --gc; nix-store --optimise";

      # Get the error messages from journalctl
      jctl="journalctl -p 3 -xb";

      # Recent installed packages
      rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl";

      music="LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify $argv";
    };
  };

}
