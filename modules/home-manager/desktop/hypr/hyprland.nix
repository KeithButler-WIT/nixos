{
  config,
  lib,
  pkgs,
  inputs,
  options,
  userSettings,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.hyprland;
  gamemode = pkgs.writeShellScriptBin "gamemode" ''
    #!/usr/bin/env sh
    HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
    if [ "$HYPRGAMEMODE" = 1 ] ; then
        hyprctl --batch "\
            keyword animations:enabled 0;\
            keyword decoration:shadow:enabled 0;\
            keyword decoration:blur:enabled 0;\
            keyword general:gaps_in 0;\
            keyword general:gaps_out 0;\
            keyword general:border_size 1;\
            keyword decoration:rounding 0"
        exit
    fi
    hyprctl reload
  '';
in {
  options.modules.desktop.hyprland = with types; {
    enable = mkBoolOpt false;
    extraConfig = mkOpt lines "";
    monitors = mkOpt (listOf (submodule {
      options = {
        output = mkOpt str "";
        mode = mkOpt str "preferred";
        position = mkOpt str "auto";
        scale = mkOpt int 1;
        disable = mkOpt bool false;
        primary = mkOpt bool false;
      };
    })) [{}];
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      #wallust # better pywal
      pavucontrol
      # wayland-egl
      brightnessctl
      galculator
      wlogout

      libnotify
      xwayland
      kdePackages.xwaylandvideobridge
    ];

    modules.desktop = {
      # tuigreet.enable = true;
      # wpaperd.enable = lib.mkDefault true;
      kanshi.enable = lib.mkDefault true;
      hyprlock.enable = lib.mkDefault true;
      hyprpaper.enable = lib.mkDefault true;
      hypridle.enable = lib.mkDefault true;
      tofi.enable = lib.mkDefault true;
      bars = {
        # ags.enable = lib.mkDefault true;
        # eww.enable = lib.mkDefault true; # TODO Fix eww
        waybar = {
          enable = lib.mkDefault true;
          vertical = lib.mkDefault true;
          # horizontal.enable = lib.mkDefault true;
        };
      };
    };

    home.pointerCursor.hyprcursor.enable = true;

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

    services.clipse = {
      enable = true;
      # historySize = 200;
    };

    services.hyprsunset = {
      enable = true;
    };

    services.hyprpolkitagent.enable = true;

    systemd.user.targets.hyprland-session.Unit.Wants = ["xdg-desktop-autostart.target"];
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      # systemd.enable = true;
      # systemd.enableXdgAutostart = true;
      xwayland.enable = true;
      plugins = [
        # inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
      ];
      settings = {
        input = {
          kb_layout = "us";
          # kb_options = "caps:swapescape";
          # kb_options = "ctrl:nocaps";
          numlock_by_default = false;
          follow_mouse = 1;
          touchpad = {
            natural_scroll = true;
            tap-to-click = true;
            disable_while_typing = true;
          };
          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        };

        general = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          gaps_in = 5;
          gaps_out = 10;
          border_size = 3;
          # "col.active_border" = "rgba (33 ccffee) rgba (8 f00ffee) 45 deg";
          # "col.inactive_border" = "rgba (595959 aa)";
          layout = "dwindle";
          allow_tearing = true;
        };

        decoration = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          rounding = 10;
          blur = {
            enabled = true;
            size = 5;
            passes = 1;
          };
          # "col.shadow" = "rgba(1e1e2e99)";
          # drop_shadow = true;
          # shadow_range = 4;
          # shadow_render_power = 3;
        };

        animations = {
          enabled = true;
          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };
        dwindle = {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # you probably want this
        };
        master = {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          # new_is_master = true;
        };
        # gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        # workspace_swipe = "on";
        # };
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };
        # monitor = cfg.monitors;
        monitor = [
          # See https://wiki.hyprland.org/Configuring/Monitors/
          "eDP-1, 1920x1080@60.04500, 0x0, 1.00"
          "HDMI-A-1, 2560x1440@59.95, 0x0, 1.00"
          # monitor= auto,1920x1080@60,auto,auto
        ];
        exec-once = [
          "${pkgs.kanshi}/bin/kanshi" # Monitor settings
          # Execute your favorite apps at launch
          "${pkgs.hyprpaper}/bin/hyprpaper"
          "${pkgs.waybar}/bin/waybar"
          # [workspace 1 silent] ${pkgs.discord}/bin/discord
          # [workspace 9 silent] ${pkgs.signal-desktop}/bin/signal-desktop
          "[workspace 10 silent] ${pkgs.thunderbird}/bin/thunderbird"
          "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"
          # ${pkgs.blueman}/bin/blueman-applet
          "${pkgs.rclone}/bin/rclone --vfs-cache-mode writes mount OneDrive: ~/OneDrive"
          "${pkgs.rclone}/bin/rclone --vfs-cache-mode writes mount GoogleDrive: ~/GoogleDrive"
          "${pkgs.pyprland}/bin/pypr"
          "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "dbus-update-activation-environment --systemd --all"
          "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        ];
        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        "$mainMod" = "SUPER";
        env = [
          "HYPRSHOT_DIR,$HOME/Pictures"
          "XDG_PICTURES_DIR,$HOME/Pictures"
          "XDG_SCREENSHOTS_DIR,$HOME/Pictures"
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
          "QT_QPA_PLATFORM,wayland,xcb"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_QPA_PLATFORMTHEME,qt5ct"
          "GDK_BACKEND,wayland,x11,*"
          "QT_QPA_PLATFORM,wayland,xcb"
          "SDL_VIDEODRIVER,wayland,x11"
          "CLUTTER_BACKEND,wayland"
        ];
        bind = [
          # Reload config
          "$mainMod SHIFT, R, exec, hyprctl reload"
          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"
          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"
          # Move to workspace with focused container with ALT + SHIFT + [0-9]
          "ALT SHIFT, 1, movetoworkspace, 1"
          "ALT SHIFT, 2, movetoworkspace, 2"
          "ALT SHIFT, 3, movetoworkspace, 3"
          "ALT SHIFT, 4, movetoworkspace, 4"
          "ALT SHIFT, 5, movetoworkspace, 5"
          "ALT SHIFT, 6, movetoworkspace, 6"
          "ALT SHIFT, 7, movetoworkspace, 7"
          "ALT SHIFT, 8, movetoworkspace, 8"
          "ALT SHIFT, 9, movetoworkspace, 9"
          "ALT SHIFT, 0, movetoworkspace, 10"
          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
          "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
          "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
          "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
          "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
          "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
          "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
          "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
          "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
          "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];
      };

      extraConfig = ''
        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
        # Example windowrule v1
        # windowrule = float, ^(kitty)$

        # Example windowrule v2
        # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

        # See https://wiki.hyprland.org/Configuring/Keywords/ for more

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = $mainMod, 36, exec, ${config.modules.desktop.term.default}
        bind = $mainMod, T, exec, ${config.modules.desktop.term.default}
        bind = $mainMod, Q, killactive,
        bind = $mainMod, N, exec, ${config.modules.desktop.file-managers.default}
        bind = $mainMod SHIFT, N, exec, ${pkgs.kitty}/bin/kitty -e ${pkgs.yazi}/bin/yazi
        bind = $mainMod SHIFT, 65, togglefloating,
        bind = $mainMod, D, exec, ${pkgs.tofi}/bin/tofi-run | xargs hyprctl dispatch exec -- # -c ~/.config/tofi/themes/soy-milk
        bind = $mainMod SHIFT, D, exec, ${pkgs.tofi}/bin/tofi-drun | xargs hyprctl dispatch exec -- # -c ~/.config/tofi/themes/fullscreen
        # bind = $mainMod, P, pseudo, # dwindle
        bind = $mainMod, O, togglesplit, # dwindle
        bind = $mainMod, ESCAPE, exec, ${pkgs.hyprlock}/bin/hyprlock
        bind = $mainMod SHIFT, ESCAPE, exec, ${pkgs.wlogout}/bin/wlogout
        bind = $mainMod, G, exec, ${gamemode}/bin/gamemode

        # Mainmod + Function keys
        # bind = $mainMod, F1, exec,
        # bind = $mainMod, F2, exec, ${pkgs.thunderbird}/bin/thunderbird
        # bind = $mainMod, F3, exec, ${pkgs.kitty}/bin/kitty ${pkgs.yazi}/bin/yazi
        bind = $mainMod, F12, exec, ${pkgs.galculator}/bin/galculator

        # Move/resize windows with mainMod + LMB/RMB and dragging`
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

        # set volume (laptops only and may or may not work on PCs)
        bind = ,122, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
        bind = ,123, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
        bind = ,121, exec, pactl set-sink-volume @DEFAULT_SINK@ 0%
        # other bindings
        bind = $mainMod, F, fullscreen
        # bind = $mainMod SHIFT, F, fakefullscreen
        bind = ,232,exec,brightnessctl -c backlight set 5%-
        bind = ,233,exec,brightnessctl -c backlight set +5%
        bindel = ,XF86MonBrightnessDown, exec, hyprctl hyprsunset gamma -10
        bindel = ,XF86MonBrightnessUp, exec, hyprctl hyprsunset gamma +10

        # Screenshots:
        # Saves to HYPRSHOT_DIR or XDG_PICTURES_DIR or ~
        bind = ,Print, exec, ${pkgs.hyprshot}/bin/hyprshot -m output
        bind = SHIFT, Print, exec, ${pkgs.hyprshot}/bin/hyprshot -m region
        bind = $mainMod, Print, exec, ${pkgs.hyprshot}/bin/hyprshot -m window
        bind = $mainMod SHIFT, Print, exec, ${pkgs.hyprshot}/bin/hyprshot -m region

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
        blurls = ${config.modules.desktop.file-managers.default}
        blurls = gtk-layer-shell # for nwg-drawer
        # window rules
        #window rules with evaluation
        windowrulev2 = opacity 0.85 0.85,floating:1

        #video play/pause bindings
        bind=,172,exec,${pkgs.playerctl}/bin/playerctl play-pause
        bind=,171,exec,${pkgs.playerctl}/bin/playerctl next
        bind=,173,exec,${pkgs.playerctl}/bin/playerctl previous

        # -----------------------------------------------------
        # Scratch Pads
        # -----------------------------------------------------

        bind = $mainMod SHIFT, RETURN, exec, ${pkgs.pyprland}/bin/pypr toggle term && hyprctl dispatch bringactivetotop
        bind = $mainMod, V,exec,${pkgs.pyprland}/bin/pypr toggle pavucontrol && hyprctl dispatch bringactivetotop
        $scratchpadsize = size 80% 85%

        $scratchpad = class:^(scratchpad)$
        windowrulev2 = float,$scratchpad
        windowrulev2 = $scratchpadsize,$scratchpad
        windowrulev2 = workspace special silent,$scratchpad
        windowrulev2 = center,$scratchpad

        $pavucontrol = class:^(pavucontrol)$
        windowrulev2 = float,$pavucontrol
        windowrulev2 = size 86% 40%,$pavucontrol
        windowrulev2 = move 50% 6%,$pavucontrol
        windowrulev2 = workspace special silent,$pavucontrol
        windowrulev2 = opacity 0.80,$pavucontrol

        windowrulev2 = idleinhibit fullscreen, class:^(*)$
        windowrulev2 = idleinhibit fullscreen, title:^(*)$
        windowrulev2 = idleinhibit fullscreen, fullscreen:1

        # -----------------------------------------------------
        # xwaylandvideobridge workaround
        # -----------------------------------------------------

        windowrulev2 = opacity 0.0 override, class:^(xwaylandvideobridge)$
        windowrulev2 = noanim, class:^(xwaylandvideobridge)$
        windowrulev2 = noinitialfocus, class:^(xwaylandvideobridge)$
        windowrulev2 = maxsize 1 1, class:^(xwaylandvideobridge)$
        windowrulev2 = noblur, class:^(xwaylandvideobridge)$

        # -----------------------------------------------------
        # Smart Gaps
        # -----------------------------------------------------

        workspace = w[tv1], gapsout:0, gapsin:0
        workspace = f[1], gapsout:0, gapsin:0
        windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
        windowrule = rounding 0, floating:0, onworkspace:w[tv1]
        windowrule = bordersize 0, floating:0, onworkspace:f[1]
        windowrule = rounding 0, floating:0, onworkspace:f[1]

        # -----------------------------------------------------
        # Tearing
        # -----------------------------------------------------

        windowrule = immediate, class:^(cs2)$ # change cs2 to game tearing is wanted

        # -----------------------------------------------------
        # Clipse
        # -----------------------------------------------------

        windowrule = float, class:(clipse)
        windowrule = size 622 652, class:(clipse)
        windowrule = stayfocused, class:(clipse)

        # bind = $mainMod, B, exec, ${config.modules.desktop.term.default} --class clipse -e clipse
        bind = $mainMod, B, exec, kitty --class clipse -e ${pkgs.clipse}/bin/clipse
        bind = $mainMod, P, exec, ${pkgs.hyprpicker}/bin/hyprpicker

        # -----------------------------------------------------
        # Steam Fix
        # -----------------------------------------------------

        windowrulev2 = stayfocused, title:^()$,class:^(steam)$
        windowrulev2 = minsize 1 1, title:^()$,class:^(steam)$

        # -----------------------------------------------------
        # Rusty Retirement Game Overlay
        # -----------------------------------------------------

        windowrulev2 = tag +rtr, title:(Rusty's Retirement)
        windowrulev2 = float, tag:rtr

        # Remove this if you don't want rtr to appear in all workspaces
        # windowrulev2 = pin, tag:rtr

        # windowrulev2 = size 100% 350, tag:rtr
        windowrulev2 = size 100% 296, tag:rtr

        # Move rtr to buttom of the screen
        # windowrulev2 = move 0 730, tag:rtr
        windowrulev2 = move 0 784, tag:rtr

        windowrulev2 = noblur, tag:rtr
        windowrulev2 = noshadow, tag:rtr
        windowrulev2 = noborder, tag:rtr
        windowrulev2 = opacity 1.0 override, tag:rtr
      '';
    };
  };
}
