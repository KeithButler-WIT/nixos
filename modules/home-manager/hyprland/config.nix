{ config, lib, pkgs, inputs, userSettings, ... }:

lib.mkIf config.modules.hyprland.enable
{

  home.file.".config/hypr/pyprland.json".text = ''
    {
        "pyprland": {
            "plugins": ["scratchpads"]
        },
        "scratchpads": {
            "term": {
                "command": "kitty --class scratchpad",
                "margin": 50,
                "unfocus": "hide",
                "lazy": true
            },
            "keepass": {
                "command": "keepassxc",
                "margin": 50,
                "unfocus": "hide",
                "animation": "fromTop",
                "lazy": true
            },
            "pavucontrol": {
                "command": "pavucontrol",
                "margin": 50,
                "unfocus": "hide",
                "animation": "fromTop",
                "lazy": true
            }
        }
    }
  '';

  home.file.".config/hypr/hyprload.toml".text = ''
    # plugins = [
    #     # Installs the plugin from https://github.com/Duckonaut/split-monitor-workspaces
    #     "Duckonaut/split-monitor-workspaces",
    # ]
  '';

  home.file.".config/hypr/wallpaper.jpg".source = ./wallpaper.jpg;
  #home.file.".config/hypr/scripts/lock.sh".source = ./scripts/lock.sh;
  #home.file.".config/hypr/scripts/sleep.sh".source = ./scripts/sleep.sh;
  #home.file.".config/wlogout".source= ./wlogout;
  #home.file.".config/wofi".source= ./wofi;

  programs.wpaperd = {
    enable = true;
    settings = {
      default = {
        # path = "/home/${userSettings.username}/Pictures/Wallpapers";
        path = "/home/${userSettings.username}/Pictures/Stålenhag";
        duration = "1h";
      };
    };
  };

  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    profiles = {
      docked = {
        outputs = [
          {
            criteria = "eDP-1";
            position = "0,1080";
            mode = "1920x1080@60Hz";
            status = "enable";
          }
          {
            criteria = "*";
            position = "0,0";
            mode = "1920x1080@60Hz";
            status = "enable";
          }
        ];
      };
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            position = "0,0";
            mode = "1920x1080@60Hz";
            status = "enable";
          }
        ];
      };
    };
  };

  # https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/
  # TODO: Get config
  home.file.".config/hypr/hyprlock.conf".text = ''
    background {
      monitor =
      path = /home/keith/Pictures/Stålenhag/*
      # path = screenshot # only png supported for now
      color = rgba(25, 20, 20, 1.0)

      # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
      blur_passes = 0 # 0 disables blurring
      blur_size = 7
      noise = 0.0117
      contrast = 0.8916
      brightness = 0.8172
      vibrancy = 0.1696
      vibrancy_darkness = 0.0
    }

    input-field {
      monitor =
      size = 200, 50
      outline_thickness = 3
      dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = false
      dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
      outer_color = rgb(151515)
      inner_color = rgb(200, 200, 200)
      font_color = rgb(10, 10, 10)
      fade_on_empty = true
      fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
      placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
      hide_input = false
      rounding = -1 # -1 means complete rounding (circle/oval)
      check_color = rgb(204, 136, 34)
      fail_color = rgb(204, 34, 34) # if authentication failed, changes outer_color and fail message color
      fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
      fail_transition = 300 # transition time in ms between normal outer_color and fail_color
      capslock_color = -1
      numlock_color = -1
      bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
      invert_numlock = false # change color if numlock is off
      swap_font_color = false # see below

      position = 0, -20
      halign = center
      valign = center
    }

    label {
      monitor =
      text = Welcome back, $USER
      color = rgba(200, 200, 200, 1.0)
      font_size = 25
      # font_family = Noto Sans
      font_family = ${userSettings.font}

      position = 0, 80
      halign = center
      valign = center
    }
  '';

  # https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/
  home.file.".config/hypr/hypridle.conf".text = ''
    general {
      lock_cmd = pidof hyprlock || hyprlock       # avoid starting multiple hyprlock instances.
      before_sleep_cmd = loginctl lock-session    # lock before suspend.
      after_sleep_cmd = hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display.
    }

    listener {
      timeout = 300                                # 5min.
      on-timeout = brightnessctl -s set 10         # set monitor backlight to minimum, avoid 0 on OLED monitor.
      on-resume = brightnessctl -r                 # monitor backlight restor.
    }

    # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
    listener {
      timeout = 300                                          # 5min.
      on-timeout = brightnessctl -sd rgb:kbd_backlight set 0 # turn off keyboard backlight.
      on-resume = brightnessctl -rd rgb:kbd_backlight        # turn on keyboard backlight.
    }

    listener {
      timeout = 600                                 # 10min
      on-timeout = loginctl lock-session            # lock screen when timeout has passed
    }

    listener {
      timeout = 630                                 # 10.5min
      on-timeout = hyprctl dispatch dpms off        # screen off when timeout has passed
      on-resume = hyprctl dispatch dpms on          # screen on when activity is detected after timeout has fired.
    }

    listener {
      timeout = 1800                                # 30min
      on-timeout = systemctl suspend                # suspend pc
    }
  '';

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    systemd.enable = true;
    xwayland.enable = true;
    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      # "/absolute/path/to/plugin.so"
      # "/home/keith/.local/share/hyprload/hyprload.so"
    ];
    settings = { };
    extraConfig = ''
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor= eDP-1, 1920x1080@60.04500, 0x0, 1.00
      monitor= HDMI-A-1, 1920x1080@60.04500, 0x0, 1.00
      # monitor= auto,1920x1080@60,auto,auto
      exec-once = ${pkgs.kanshi}/bin/kanshi

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      # exec-once = ${pkgs.hyprpaper}/bin/hyprpaper
      # exec-once = [workspace 1 silent] ${pkgs.vesktop}/bin/vesktop
      # exec-once = [workspace 1 silent] ${pkgs.steam}/bin/steam
      # exec-once = [workspace 9 silent] ${pkgs.signal-desktop}/bin/signal-desktop
      exec-once = [workspace 10 silent] ${pkgs.thunderbird}/bin/thunderbird

      # Add networkmanager applet to tray in waybar
      exec-once = ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator
      # exec-once = ${pkgs.blueman}/bin/blueman-applet

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =
          numlock_by_default= false
          follow_mouse = 1

        touchpad {
            natural_scroll = true
            tap-to-click = true
            disable_while_typing = true
        }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5
          gaps_out = 10
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(8f00ffee) 45deg
          col.inactive_border = rgba(595959aa)

          layout = dwindle
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 10
          blur {
            enabled = true
            size = 5
            passes = 1
          }

          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = true

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = on
      }
      misc {
          disable_hyprland_logo = true
          disable_splash_rendering = true
      }
      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      #device:epic mouse V1 {
      #    sensitivity = -0.5
      #}

      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # Example windowrule v1
      # windowrule = float, ^(kitty)$

      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod SHIFT, R, exec, hyprctl reload
      bind = $mainMod, 36, exec, ${pkgs.kitty}/bin/kitty
      bind = $mainMod, T, exec, ${pkgs.kitty}/bin/kitty
      bind = $mainMod, Q, killactive,
      bind = $mainMod, N, exec, thunar
      bind = $mainMod SHIFT, 65, togglefloating,
      bind = $mainMod, D, exec, ${pkgs.tofi}/bin/tofi-run -c ~/.config/tofi/themes/soy-milk
      bind = $mainMod SHIFT, D, exec, ${pkgs.tofi}/bin/tofi-drun -c ~/.config/tofi/themes/fullscreen
      # bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle
      bind = $mainMod, ESCAPE, exec, hyprlock
      bind = $mainMod SHIFT, ESCAPE, exec, ${pkgs.wlogout}/bin/wlogout
      
      # Mainmod + Function keys
      # bind = $mainMod, F1, exec, ${pkgs.discord}/bin/discord
      # bind = $mainMod, F1, exec, ${pkgs.steam}/bin/steam
      bind = $mainMod, F1, exec, ${pkgs.floorp}/bin/floorp
      bind = $mainMod, F2, exec, ${pkgs.thunderbird}/bin/thunderbird
      bind = $mainMod, F3, exec, ${pkgs.kitty}/bin/kitty ${pkgs.lf}/bin/lf
      bind = $mainMod, F4, exec, ${pkgs.vesktop}/bin/vesktop
      # bind = $mainMod, F5, exec, ${pkgs.github-desktop}/bin/github-desktop
      # bind = $mainMod, F6, exec,  ${pkgs.gparted}/bin/gparted
      bind = $mainMod, F12, exec, ${pkgs.galculator}/bin/galculator

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move to workspace with focused container with ALT + SHIFT + [0-9]
      bind = ALT SHIFT, 1, movetoworkspace, 1
      bind = ALT SHIFT, 2, movetoworkspace, 2
      bind = ALT SHIFT, 3, movetoworkspace, 3
      bind = ALT SHIFT, 4, movetoworkspace, 4
      bind = ALT SHIFT, 5, movetoworkspace, 5
      bind = ALT SHIFT, 6, movetoworkspace, 6
      bind = ALT SHIFT, 7, movetoworkspace, 7
      bind = ALT SHIFT, 8, movetoworkspace, 8
      bind = ALT SHIFT, 9, movetoworkspace, 9
      bind = ALT SHIFT, 0, movetoworkspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
      bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
      bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
      bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
      bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
      bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging`
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      #background
      exec-once = ${pkgs.wpaperd}/bin/wpaperd
      exec-once = hypridle #~/.config/hypr/scripts/sleep.sh

      #status bar
      layerrule = blur , waybar
      layerrule = ignorezero , waybar

      # set volume (laptops only and may or may not work on PCs)
      bind = ,122, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
      bind = ,123, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
      bind = ,121, exec, pactl set-sink-volume @DEFAULT_SINK@ 0%
      # other bindings
      #bind = $mainMod, O, exec, floorp
      bind = $mainMod, F, fullscreen
      bind = $mainMod SHIFT, F, fakefullscreen
      bind = ,232,exec,brightnessctl -c backlight set 5%-
      bind = ,233,exec,brightnessctl -c backlight set +5%
      bind = $mainMod SHIFT,C, exec, killall -9 wpaperd && wpaperd

      # Screenshots:

      # https://github.com/hyprwm/contrib/blob/main/grimblast/grimblast.1.scd
      # Print: All outputs
      # SHIFT+Print: Select area
      # $mainMod+Print: Current window
      # $mainMod+Shfit+Print: Current output

      bind = ,Print, exec, grimblast save screen && notify-send Screenshot captured
      bind = SHIFT, Print, exec, grimblast save area && notify-send Selected\ area captured
      bind = $mainMod, Print, exec, grimblast save active && notify-send Active\ window captured
      bind = $mainMod SHIFT, Print, exec, grimblast output active && notify-send Output captured

      # for resizing window
      # will switch to a submap called resize
      bind=$mainMod,R,submap,resize

      # will start a submap called "resize"
      submap=resize

      # sets repeatable binds for resizing the active window
      binde=,right,resizeactive,10 0
      binde=,left,resizeactive,-10 0
      binde=,up,resizeactive,0 -10
      binde=,down,resizeactive,0 10

      # use reset to go back to the global submap
      bind=,escape,submap,reset

      # will reset the submap, meaning end the current one and return to the global one
      submap=reset

      # to move window
      bind = $mainMod SHIFT,up, movewindow, u
      bind = $mainMod SHIFT,down, movewindow, d
      bind = $mainMod SHIFT,left, movewindow, l
      bind = $mainMod SHIFT,right, movewindow, r

      # other blurings
      blurls = wofi
      blurls = thunar
      blurls = gedit
      blurls = gtk-layer-shell # for nwg-drawer
      blurls = catfish
      # window rules
      windowrule = opacity 0.85 override 0.85 override,^(thunar)$
      windowrule = opacity 0.85 override 0.85 override,^(gedit)$
      windowrule = opacity 0.85 override 0.85 override,^(catfish)$
      #window rules with evaluation
      windowrulev2 = opacity 0.85 0.85,floating:1

      # exec-once = ${pkgs.mako}/bin/mako
      # exec-once =/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
      # exec-once = emacs --daemon
      # experimental(might work might won't)

      #pre executions (under development)
      exec-once=exec ${pkgs.xorg.xrdb}/bin/xrdb -load ~/.Xresources
      exec-once= ${pkgs.copyq}/bin/copyq

      #video play/pause bindings
      bind=,172,exec,${pkgs.playerctl}/bin/playerctl play-pause
      bind=,171,exec,${pkgs.playerctl}/bin/playerctl next
      bind=,173,exec,${pkgs.playerctl}/bin/playerctl previous

      # Use gtk-settings
      #exec-once = apply-gsettings

      # colour-temperature setting depending on the time [https://github.com/d4l3k/go-sct]
      exec-once = ${pkgs.go-sct}/bin/waysct
      exec-once = thunar --daemon # auto mount removeable media
      # exec-once = xremap ~/.config/xremap/config.yaml
      exec-once = ${pkgs.rclone}/bin/rclone --vfs-cache-mode writes mount OneDrive: ~/OneDrive
      exec-once = ${pkgs.rclone}/bin/rclone --vfs-cache-mode writes mount GoogleDrive: ~/GoogleDrive

      # -----------------------------------------------------
      # Scratch Pads
      # -----------------------------------------------------

      exec-once = ${pkgs.pyprland}/bin/pypr

      bind = $mainMod SHIFT, RETURN, exec, ${pkgs.pyprland}/bin/pypr toggle term && hyprctl dispatch bringactivetotop
      bind = $mainMod, V,exec,${pkgs.pyprland}/bin/pypr toggle pavucontrol && hyprctl dispatch bringactivetotop
      bind = $mainMod, P,exec,${pkgs.pyprland}/bin/pypr toggle keepass && hyprctl dispatch bringactivetotop
      $scratchpadsize = size 80% 85%

      $scratchpad = class:^(scratchpad)$
      windowrulev2 = float,$scratchpad
      windowrulev2 = $scratchpadsize,$scratchpad
      windowrulev2 = workspace special silent,$scratchpad
      windowrulev2 = center,$scratchpad

      $keepass = class:^(keepassxc)$
      windowrulev2 = float,$keepassxc
      windowrulev2 = $scratchpadsize,$scratchpad
      windowrulev2 = workspace special silent,$scratchpad
      windowrulev2 = center,$scratchpad

      $pavucontrol = class:^(pavucontrol)$
      windowrulev2 = float,$pavucontrol
      windowrulev2 = size 86% 40%,$pavucontrol
      windowrulev2 = move 50% 6%,$pavucontrol
      windowrulev2 = workspace special silent,$pavucontrol
      windowrulev2 = opacity 0.80,$pavucontrol

      # -----------------------------------------------------
      # Plugins
      # -----------------------------------------------------

      # exec-once=$HOME/.local/share/hyprload/hyprload.sh

      # plugin {
      #     split-monitor-workspaces {
      #         count = 10
      #     }
      # }
    '';
  };

}
