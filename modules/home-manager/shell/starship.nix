{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.starship;
in {

  options.modules.shell.starship.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      # enableZshIntegration = true;
      enableNushellIntegration = true;
      enableTransience = true;

      settings = {
        ## FIRST LINE/ROW: Info & Status
        # First param ─┌
        username = {
          format = " [╭─$user]($style)@";
          show_always = true;
          style_root = "bold red";
          style_user = "bold red";
        };

        # Second param
        hostname = {
          disabled = false;
          format = "[$hostname]($style) in ";
          ssh_only = false;
          style = "bold dimmed red";
          trim_at = "-";
        };

        # Third param
        directory = {
          style = "purple";
          truncate_to_repo = true;
          truncation_length = 2;
          truncation_symbol = "../";
        };

        # Fourth param
        sudo = {
          disabled = false;
        };

        # Before all the version info (python, nodejs, php, etc.)
        git_status = {
          ahead = "⇡{count}";
          behind = "⇣{count}";
          deleted = "x";
          diverged = "⇕⇡{ahead_count}⇣{behind_count}";
          style = "white";
        };

        # Last param in the first line/row
        cmd_duration = {
          disabled = false;
          format = "took [$duration]($style)";
          min_time = 1;
        };


        ## SECOND LINE/ROW: Prompt
        # Somethere at the beginning
        # battery = {
        #   charging_symbol = "";
        #   disabled = true;
        #   discharging_symbol = "";
        #   full_symbol = "";
        # };

        # # "bold red" style when capacity is between 0% and 10%
        # battery.display = {
        #   disabled = true;
        #   style = "bold red";
        #   threshold = 15;
        # };

        # # "bold yellow" style when capacity is between 10% and 30%
        # battery.display = {
        #   disabled = true;
        #   style = "bold yellow";
        #   threshold = 50;
        # };

        # # "bold green" style when capacity is between 10% and 30%
        # battery.display = {
        #   disabled = true;
        #   style = "bold green";
        #   threshold = 80;
        # };

        # Prompt: optional param 1
        time = {
          disabled = true;
          format = " 🕙 $time($style)\n";
          style = "bright-white";
          time_format = "%T";
        };

        # Prompt: param 2
        character = {
          error_symbol = " [×](bold red)";
          success_symbol = " [╰─λ](bold red)";
        };

        # SYMBOLS
        status = {
          disabled = false;
          format = ''[\[$symbol$status_common_meaning$status_signal_name$status_maybe_int\]]($style)'';
          map_symbol = true;
          pipestatus = true;
          symbol = "🔴";
        };

        aws = {
          symbol = " ";
        };

        c = {
          symbol = "C ";
        };

        conda = {
          symbol = " ";
        };

        dart = {
          symbol = " ";
        };

        docker_context = {
          symbol = " ";
        };

        elixir = {
          symbol = " ";
        };

        elm = {
          symbol = " ";
        };

        git_branch = {
          symbol = " ";
        };

        golang = {
          symbol = " ";
        };

        hg_branch = {
          symbol = " ";
        };

        java = {
          symbol = " ";
        };

        julia = {
          symbol = " ";
        };

        nim = {
          symbol = " ";
        };

        nix_shell = {
          symbol = " ";
        };

        nodejs = {
          symbol = " ";
        };

        package = {
          symbol = " ";
        };

        perl = {
          symbol = " ";
        };

        php = {
          symbol = " ";
        };

        python = {
          symbol = " ";
        };

        ruby = {
          symbol = " ";
        };

        rust = {
          symbol = " ";
        };

        swift = {
          symbol = "ﯣ ";
        };
      };
    };
  };

}