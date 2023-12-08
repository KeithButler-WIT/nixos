{ config, lib, pkgs, ... }:

{

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # TODO stop using stow
      ".dmenurc".source = ~/.dotfiles/.dmenurc;
      ".xinitrc".source = ~/.dotfiles/.xinitrc;
      # dunst
      ".config/keepassxc".source = ../keepassxc;
      # openmw
      # ${config.xdg.configHome}."/picom".source = ~/.dotfiles/.config/picom;
      ".config/picom".source = ~/.dotfiles/.config/picom;
      # qtile

     ".Xresources".text = ''
        *background: #1E1E2E
        *foreground: #CDD6F4

        ! black
        *color0: #45475A
        *color8: #585B70

        ! red
        *color1: #F38BA8
        *color9: #F38BA8

        ! green
        *color2: #A6E3A1
        *color10: #A6E3A1

        ! yellow
        *color3: #F9E2AF
        *color11: #F9E2AF

        ! blue
        *color4: #89B4FA
        *color12: #89B4FA

        ! magenta
        *color5: #F5C2E7
        *color13: #F5C2E7

        ! cyan
        *color6: #94E2D5
        *color14: #94E2D5

        ! white
        *color7: #BAC2DE
        *color15: #A6ADC8
     '';

      ".config/rofi/config.rasi".text = ''
        configuration {
            display-drun: "Applications";
            display-window: "drun";
            drun-display-format: "{name}";
            font: "Fira Sans SemiBold 11";
            modi: "run,drun";
            /* show-icons: true; */
        }

        window {
            width:700px;
        }

        element {
            padding:6;
        }

        element-text selected {
            text-color:#${config.colorScheme.colors.base00};
        }

        prompt {
            text-color:#${config.colorScheme.colors.base0F};
        }

        entry {
            text-color:#${config.colorScheme.colors.base0A};
        }

        /* vim: ft=sass
        '';

      ".cache/nix-colors/colors.py".text = ''
        #!/usr/bin/env python3

        colors = {
            "00": "${config.colorScheme.colors.base00}",
            "01": "${config.colorScheme.colors.base01}",
            "02": "${config.colorScheme.colors.base02}",
            "03": "${config.colorScheme.colors.base03}",
            "04": "${config.colorScheme.colors.base04}",
            "05": "${config.colorScheme.colors.base05}",
            "06": "${config.colorScheme.colors.base06}",
            "07": "${config.colorScheme.colors.base07}",
            "08": "${config.colorScheme.colors.base08}",
            "09": "${config.colorScheme.colors.base09}",
            "10": "${config.colorScheme.colors.base0A}",
            "11": "${config.colorScheme.colors.base0B}",
            "12": "${config.colorScheme.colors.base0C}",
            "13": "${config.colorScheme.colors.base0D}",
            "14": "${config.colorScheme.colors.base0E}",
            "15": "${config.colorScheme.colors.base0F}"
        }'';

      ".cache/nix-colors/colors".text = ''
        #${config.colorScheme.colors.base00}
        #${config.colorScheme.colors.base01}
        #${config.colorScheme.colors.base02}
        #${config.colorScheme.colors.base03}
        #${config.colorScheme.colors.base04}
        #${config.colorScheme.colors.base05}
        #${config.colorScheme.colors.base06}
        #${config.colorScheme.colors.base07}
        #${config.colorScheme.colors.base08}
        #${config.colorScheme.colors.base09}
        #${config.colorScheme.colors.base0A}
        #${config.colorScheme.colors.base0B}
        #${config.colorScheme.colors.base0C}
        #${config.colorScheme.colors.base0D}
        #${config.colorScheme.colors.base0E}
        #${config.colorScheme.colors.base0F}
        '';

      ".cache/nix-colors/colors-hyprland.conf".text = ''
            $background = rgb(${config.colorScheme.colors.base00})
            $foreground = rgb(${config.colorScheme.colors.base00})
            $color0 = rgb(${config.colorScheme.colors.base00})
            $color1 = rgb(${config.colorScheme.colors.base01})
            $color2 = rgb(${config.colorScheme.colors.base02})
            $color3 = rgb(${config.colorScheme.colors.base03})
            $color4 = rgb(${config.colorScheme.colors.base04})
            $color5 = rgb(${config.colorScheme.colors.base05})
            $color6 = rgb(${config.colorScheme.colors.base06})
            $color7 = rgb(${config.colorScheme.colors.base07})
            $color8 = rgb(${config.colorScheme.colors.base08})
            $color9 = rgb(${config.colorScheme.colors.base09})
            $color10 = rgb(${config.colorScheme.colors.base0A})
            $color11 = rgb(${config.colorScheme.colors.base0B})
            $color12 = rgb(${config.colorScheme.colors.base0C})
            $color13 = rgb(${config.colorScheme.colors.base0D})
            $color14 = rgb(${config.colorScheme.colors.base0E})
            $color15 = rgb(${config.colorScheme.colors.base0F})
        '';

      ".cache/nix-colors/colors-waybar.css".text = ''
            @define-color foreground #${config.colorScheme.colors.base00};
            @define-color background #${config.colorScheme.colors.base00};
            @define-color cursor #${config.colorScheme.colors.base0F};

            @define-color color0 #${config.colorScheme.colors.base00};
            @define-color color1 #${config.colorScheme.colors.base01};
            @define-color color2 #${config.colorScheme.colors.base02};
            @define-color color3 #${config.colorScheme.colors.base03};
            @define-color color4 #${config.colorScheme.colors.base04};
            @define-color color5 #${config.colorScheme.colors.base05};
            @define-color color6 #${config.colorScheme.colors.base06};
            @define-color color7 #${config.colorScheme.colors.base07};
            @define-color color8 #${config.colorScheme.colors.base08};
            @define-color color9 #${config.colorScheme.colors.base09};
            @define-color color10 #${config.colorScheme.colors.base0A};
            @define-color color11 #${config.colorScheme.colors.base0B};
            @define-color color12 #${config.colorScheme.colors.base0C};
            @define-color color13 #${config.colorScheme.colors.base0D};
            @define-color color14 #${config.colorScheme.colors.base0E};
            @define-color color15 #${config.colorScheme.colors.base0F};
        '';

      ".cache/nix-colors/colors-wlogout.css".text = ''
            @define-color foreground #${config.colorScheme.colors.base00};
            @define-color background #${config.colorScheme.colors.base00};
            @define-color cursor #${config.colorScheme.colors.base0F};

            @define-color color0 #${config.colorScheme.colors.base00};
            @define-color color1 #${config.colorScheme.colors.base01};
            @define-color color2 #${config.colorScheme.colors.base02};
            @define-color color3 #${config.colorScheme.colors.base03};
            @define-color color4 #${config.colorScheme.colors.base04};
            @define-color color5 #${config.colorScheme.colors.base05};
            @define-color color6 #${config.colorScheme.colors.base06};
            @define-color color7 #${config.colorScheme.colors.base07};
            @define-color color8 #${config.colorScheme.colors.base08};
            @define-color color9 #${config.colorScheme.colors.base09};
            @define-color color10 #${config.colorScheme.colors.base0A};
            @define-color color11 #${config.colorScheme.colors.base0B};
            @define-color color12 #${config.colorScheme.colors.base0C};
            @define-color color13 #${config.colorScheme.colors.base0D};
            @define-color color14 #${config.colorScheme.colors.base0E};
            @define-color color15 #${config.colorScheme.colors.base0F};
        '';

    };


}
