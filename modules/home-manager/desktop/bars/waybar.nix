{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.waybar;
in {

  options.modules.desktop.waybar = {
    enable = mkBoolOpt false;
    horizontal.enable = mkBoolOpt false;
    vertical.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable (mkMerge [
    { }

    (mkIf (cfg.horizontal.enable && !cfg.vertical.enable) {
      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 40;
            width = 1900;
            margin = "0 0 0 0";
            spacing = 0;
            modules-left = [
              "hyprland/workspaces"
              "hyprland/window"
            ];
            modules-center = [
              "clock"
            ];
            modules-right = [
              "custom/network_traffic"
              "backlight"
              "temperature"
              "cpu"
              "memory"
              "battery"
              "pulseaudio"
              "tray"
              "idle_inhibitor"
              "custom/power"
            ];

            # Modules configuration
            "hyprland/workspaces" = {
              format = "{icon}";
              on-click = "activate";
              all-outputs = false;
              sort-by-number = true;
              format-icons = {
                "1" = "1";
                "2" = "2";
                "3" = "3";
                "4" = "4";
                "5" = "5";
                "6" = "6";
                "7" = "7";
                "8" = "8";
                "9" = "9";
                "10" = "10";
                "focused" = "";
                "default" = "";
              };
              on-scroll-up = "hyprctl dispatch workspace e+1";
              on-scroll-down = "hyprctl dispatch workspace e-1";
            };
            "hyprland/window" = {
              format = "{}";
              icon = true;
              icon-size = 14;
            };
            idle_inhibitor = {
              format = "{icon}";
              format-icons = {
                activated = "";
                deactivated = "";
              };
            };
            tray = {
              icon-size = 14;
              spacing = 5;
            };
            clock = {
              tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
              format = " {:%a %d %b  %I:%M %p}"; # 12 hour format
              #format = " {:%a %d %b  %H:%M}";	  # 24 hour format
              format-alt = " {:%d/%m/%Y  %H:%M:%S}";
              timezones = [
                "Europe/Dublin"
              ];
              #max-length = 200
              interval = 1;
              on-click = (pkgs.writeShellScript "OCV" ''
                #!/bin/bash

                ${pkgs.yad}/bin/yad --width=400 --height=200 \
                --center \
                --fixed \
                --title="Calendar" \
                --no-buttons \
                --timeout=20 \
                --timeout-indicator=bottom \
                ${pkgs.yad}/bin/yad \
                --calendar
              '');
            };
            cpu = {
              format = "🖳{usage}%";
              on-click = "${pkgs.kitty}/bin/kitty ${pkgs.btop}/bin/btop -p 1";
            };
            memory = {
              format = "🖴 {: >3}%";
              on-click = "${pkgs.kitty}/bin/kitty ${pkgs.btop}/bin/btop -p 1";
            };
            temperature = {
              thermal-zone = 7; # Check with: # cat /sys/class/hwmon/hwmon*/temp1_input
              hwmon-path = "/sys/class/hwmon/hwmon7/temp1_input";
              critical-threshold = 80;
              format-critical = "{temperatureC}°C ";
              format = "{temperatureC}°C ";
            };
            backlight = {
              # device = "acpi_video1";
              format = "{icon} {percent: >3}%";
              format-icons = {
                off = "";
                one = "";
              };
              on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl -c backlight set 1%-";
              on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl -c backlight set +1%";
              on-click = (pkgs.writeShellScript "backlight-hint" ''
                #!/bin/bash

                ${pkgs.yad}/bin/yad --width=100 --height=100 \
                --center \
                --fixed \
                --title="Backlight" \
                --no-buttons \
                --timeout=10 \
                --timeout-indicator=bottom \
                ${pkgs.yad}/bin/yad \
                --text="\nScroll your mouse wheel to change \n      the backlight of the monitor." \
              '');
            };
            battery = {
              states = {
                # good = 95;
                warning = 30;
                critical = 15;
              };
              format = "{icon} {capacity: >3}%";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
              ];
            };
            network = {
              # "interface" = "wlp0s20f3", // (Optional) To force the use of this interface  format-wifi = "  {essid}";
              format = "⚠Disabled";
              format-wifi = " ";
              format-ethernet = "{ifname}: {ipaddr}/{cidr}";
              format-linked = "{ifname} (No IP)";
              format-disconnected = "⚠Disabled";
              format-alt = "{ifname}: {ipaddr}/{cidr}";
              family = "ipv4";
              tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
              tooltip-format-ethernet = " {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}";
              # min-length = 2;
              # max-length = 2;
              on-click = "nm-connection-editor";
            };
            "custom/power" = {
              format = "⏻";
              # TODO: change to the other one
              # on-click = "${pkgs.nwgbar}/bin/nwgbar";
              tooltip = false;
            };
            "custom/launcher" = {
              format = "";
              # on-click = "exec nwg-drawer -c 7 -is 70 -spacing 23";
              tooltip = false;
            };
            "custom/network_traffic" = {
              exec = "~/.config/waybar/scripts/network_traffic.sh";
              return-type = "json";
              format-ethernet = "{icon} {ifname} ⇣{bandwidthDownBytes} ⇡{bandwidthUpBytes}"; # optional
            };
            pulseaudio = {
              scroll-step = 3; # %, can be a float
              format = "{icon} {volume}% {format_source}";
              format-bluetooth = "{volume}% {icon} {format_source}";
              format-bluetooth-muted = " {icon} {format_source}";
              format-muted = " {format_source}";
              # format-source = "{volume}% ",
              # format-source-muted = "",
              format-source = "";
              format-source-muted = "";
              format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = [
                  ""
                  ""
                  ""
                ];
              };
              on-click = "pavucontrol";
              on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
            };
          };
        };

        style = ''
          /* =============================================================================
           *
           * Waybar configuration
           *
           * Configuration reference: https://github.com/Alexays/Waybar/wiki/Configuration
           *
           * =========================================================================== */

          /* -----------------------------------------------------------------------------
           * Base styles
           * -------------------------------------------------------------------------- */

          /* Reset all styles */

          * {
            color: #eceff4;
            border: 0;
            border-radius: 0;
            padding: 0 0;
            font-family:Symbols Nerd Font Mono;
            font-size: 14px;
            margin-right: 4px;
            margin-left: 4px;
            padding-bottom:2px;
            }

            window#waybar {
            background:rgba (0, 0, 0, 0.5);
            border-radius: 20px 20px 20px 20px;
            }

            #workspaces button {
            padding: 2px 0px;
            border-bottom: 2px;
            color: #eceff4;
            border-color: #d8dee9;
            border-style: solid;
            margin-top:2px;
            }

            #workspaces button.active {
            border-color: #81a1c1;
            }

            #clock, #battery, #cpu, #memory,#idle_inhibitor, #temperature,#custom-keyboard-layout, #backlight, #network, #pulseaudio, #tray, #window,#custom-launcher,#custom-power,#custom-pacman ,#custom-network_traffic,#custom-weather{
            padding: 0 3px;
            border-bottom: 2px;
            border-style: solid;
            }

            /* -----------------------------------------------------------------------------
             * Module styles
             * -------------------------------------------------------------------------- */


            #clock {
            color:#a3be8c;
            }

            #backlight {
            color: #ebcb8b;
            }

            #battery {
            color: #d8dee9;
            }

            #battery.charging {
            color: #81a1c1;
            }

            @keyframes blink {
            to {
            color: #4c566a;
            background-color: #eceff4;
            }
            }

            #battery.critical:not(.charging) {
            background: #bf616a;
            color: #eceff4;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
            }

            #cpu {
            color:#a3be8c ;
            }

            #memory {
            color: #d3869b;
            }

            #network.disabled {
            color:#bf616a;
            }

            #network{
            color:#a3be8c;
            }

            #network.disconnected {
            color: #bf616a;
            }

            #pulseaudio {
            color: #b48ead;
            }

            #pulseaudio.muted {
            color: #3b4252;
            }

            #temperature {
            color: #8fbcbb;
            }

            #temperature.critical {
            color: #bf616a;
            }

            #idle_inhibitor {
            color: #ebcb8b;
            }

            #tray {
            }

            #custom-launcher,#custom-power{
            border-style: hidden;
            margin-top:2px;
            }

            #window{
            border-style: hidden;
            margin-top:1px;
            }
            #custom-keyboard-layout{
            color:#d08770;
            }
            #custom-network_traffic{
            color:#d08770;
            }
        '';

        systemd.enable = true;

      };
    })

    (mkIf (cfg.vertical.enable && !cfg.horizontal.enable) {
      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "left";
            margin = "5 2 5 0";
            reload_style_on_change = true;
            modules-left = [
              "custom/updates"
              "hyprland/workspaces"
              "hyprland/submap"
              "group/info"
            ];
            "hyprland/workspaces" = {
              format = "{icon}";
              on-click = "activate";
              all-outputs = true;
              format-icons = {
                "1" = "1";
                "2" = "2";
                "3" = "3";
                "4" = "4";
                "5" = "5";
                "6" = "6";
                "7" = "7";
                "8" = "8";
                "9" = "9";
                "10" = "0";
              };
            };
            "hyprland/submap" = {
              format = "<b>󰇘</b>";
              max-length = 8;
              tooltip = true;
            };
            "group/info" = {
              orientation = "inherit";
              drawer = {
                transition-duration = 500;
                transition-left-to-right = false;
              };
              modules = [
                "custom/dmark"
                "group/gcpu"
                "memory"
                "disk"
              ];
            };
            "custom/dmark" = {
              format = "";
              tooltip = false;
            };
            "group/gcpu" = {
              orientation = "inherit";
              modules = [
                "custom/cpu-icon"
                "custom/cputemp"
                "cpu"
              ];
            };
            "custom/cpu-icon" = {
              format = "󰻠";
              tooltip = false;
            };
            "custom/cputemp" = {
              format = "{}";
              exec = "~/.config/waybar/bin/cputemp";
              interval = 10;
              return-type = "json";
            };
            "cpu" = {
              format = "<b>{usage}󱉸</b>";
              on-click = "foot btop";
            };
            "memory" = {
              format = "<b>  \n{ =2}󱉸</b>";
            };
            "disk" = {
              interval = 600;
              format = "<b> 󰋊 \n{percentage_used}󱉸</b>";
              "path" = "/";
            };
            "modules-right" = [
              "custom/recorder"
              "privacy"
              "group/brightness"
              "group/sound"
              "group/connection"
              "group/together"
              "group/cnoti"
              "tray"
              "group/power"
            ];
            "custom/recorder" = {
              format = "{}";
              interval = "once";
              exec = "echo ''";
              tooltip = "false";
              exec-if = "pgrep 'wl-screenrec'";
              on-click = "recorder";
              signal = 4;
            };
            privacy = {
              orientation = "vertical";
              icon-spacing = 4;
              icon-size = 14;
              transition-duration = 250;
              modules = {
                "type" = "screenshare";
                "tooltip" = true;
                "tooltip-icon-size" = 24;
              };
            };
            "group/brightness" = {
              orientation = "inherit";
              drawer = {
                transition-duration = 500;
                transition-left-to-right = false;
              };
              modules = [
                "backlight"
                "backlight/slider"
              ];
            };
            "backlight" = {
              device = "intel_backlight";
              format = "{icon}";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
                ""
                ""
                ""
                ""
                ""
                ""
                ""
                ""
                ""
                ""
              ];
              on-scroll-down = "brightnessctl s 5%-";
              on-scroll-up = "brightnessctl s +5%";
              tooltip = true;
              tooltip-format = "Brightness = {percent}% ";
              smooth-scrolling-threshold = 1;
            };
            "backlight/slider" = {
              min = 5;
              max = 100;
              orientation = "vertical";
              device = "intel_backlight";
            };
            "group/sound" = {
              orientation = "inherit";
              modules = [
                "group/audio"
                "custom/notifications"
              ];
            };
            "group/audio" = {
              orientation = "inherit";
              drawer = {
                transition-duration = 500;
                transition-left-to-right = false;
              };
              modules = [
                "pulseaudio"
                "pulseaudio#mic"
                "pulseaudio/slider"
              ];
            };
            "group/cnoti" = {
              orientation = "inherit";
              modules = [
                "custom/github"
              ];
            };
            "group/connection" = {
              orientation = "inherit";
              modules = [
                "custom/vpn"
                "custom/hotspot"
                "group/network"
                "group/bluetooth"
              ];
            };
            "group/together" = {
              orientation = "inherit";
              modules = [
                "group/utils"
                "clock"
              ];
            };
            "group/utils" = {
              orientation = "inherit";
              drawer = {
                transition-duration = 500;
                transition-left-to-right = true;
              };
              modules = [
                "custom/mark"
                "custom/weather"
                "custom/colorpicker"
                "custom/hyprshade"
                "idle_inhibitor"
                "custom/hyprkill"
              ];
            };
            "group/network" = {
              orientation = "inherit";
              drawer = {
                transition-duration = 500;
                transition-left-to-right = true;
              };
              modules = [
                "network"
                "network#speed"
              ];
            };
            "group/bluetooth" = {
              orientation = "inherit";
              drawer = {
                transition-duration = 500;
                transition-left-to-right = true;
              };
              modules = [
                "bluetooth"
                "bluetooth#status"
              ];
            };
            "group/power" = {
              orientation = "inherit";
              drawer = {
                transition-duration = 500;
                transition-left-to-right = false;
              };
              modules = [
                "battery"
                "power-profiles-daemon"
              ];
            };
            tray = {
              icon-size = 18;
              spacing = 10;
            };
            "pulseaudio" = {
              format = "{icon}";
              format-bluetooth = "{icon}";
              tooltip-format = "{volume}% {icon} | {desc}";
              format-muted = "󰖁";
              format-icons = {
                headphones = "󰋌";
                handsfree = "󰋌";
                headset = "󰋌";
                phone = "";
                portable = "";
                car = "";
                default = [
                  "󰕿"
                  "󰖀"
                  "󰕾"
                ];
              };
              on-click = "volume mute";
              on-click-middle = "pavucontrol";
              on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
              on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
              smooth-scrolling-threshold = 1;
            };
            "pulseaudio#mic" = {
              format = "{format_source}";
              format-source = "";
              format-source-muted = "";
              tooltip-format = "{volume}% {format_source} ";
              on-click = "pactl set-source-mute 0 toggle";
              on-scroll-down = "pactl set-source-volume 0 -1%";
              on-scroll-up = "pactl set-source-volume 0 +1%";
            };
            "pulseaudio/slider" = {
              min = 0;
              max = 140;
              orientation = "vertical";
            };
            "network" = {
              format = "{icon}";
              format-icons = {
                wifi = [
                  "󰤨"
                ];
                ethernet = [
                  "󰈀"
                ];
                disconnected = [
                  "󰖪"
                ];
              };
              format-wifi = "󰤨";
              format-ethernet = "󰈀";
              format-disconnected = "󰖪";
              format-linked = "󰈁";
              tooltip = false;
              on-click = "pgrep -x rofi &>/dev/null && notify-send rofi || networkmanager_dmenu";
            };
            "network#speed" = {
              format = " {bandwidthDownBits} ";
              rotate = 90;
              interval = 5;
              tooltip-format = "{ipaddr}";
              tooltip-format-wifi = "{essid} ({signalStrength}%)   \n{ipaddr} | {frequency} MHz{icon} ";
              tooltip-format-ethernet = "{ifname} 󰈀 \n{ipaddr} | {frequency} MHz{icon} ";
              tooltip-format-disconnected = "Not Connected to any type of Network";
              tooltip = true;
              on-click = "pgrep -x rofi &>/dev/null && notify-send rofi || networkmanager_dmenu";
            };
            "bluetooth" = {
              format-on = "";
              format-off = "󰂲";
              format-disabled = "";
              format-connected = "<b></b>";
              tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
              tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
              tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
              tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
              on-click = "rofi-bluetooth -config ~/.config/rofi/menu.d/network.rasi -i";
            };
            "bluetooth#status" = {
              format-on = "";
              format-off = "";
              format-disabled = "";
              format-connected = "<b>{num_connections}</b>";
              format-connected-battery = "<small><b>{device_battery_percentage}%</b></small>";
              tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
              tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
              tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
              tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
              on-click = "rofi-bluetooth -config ~/.config/rofi/menu.d/network.rasi -i";
            };
            battery = {
              rotate = 270;
              states = {
                good = 95;
                warning = 30;
                critical = 15;
              };
              format = "{icon}";
              format-charging = "<b>{icon} </b>";
              format-full = "<span color='#82A55F'><b>{icon}</b></span>";
              format-icons = [
                "󰁻"
                "󰁼"
                "󰁾"
                "󰂀"
                "󰂂"
                "󰁹"
              ];
              tooltip-format = "{timeTo} {capacity} % | {power} W";
            };
            clock = {
              format = "{ =%H\n%M}";
              tooltip-format = "<tt><small>{calendar}</small></tt>";
              calendar = {
                mode = "month";
                mode-mon-col = 3;
                weeks-pos = "right";
                on-scroll = 1;
                on-click-right = "mode";
                format = {
                  today = "<span color='#a6e3a1'><b><u>{}</u></b></span>";
                };
              };
            };
            power-profiles-daemon = {
              format = "{icon}";
              tooltip-format = "Power profile = {profile}\nDriver = {driver}";
              tooltip = true;
              format-icons = {
                default = "";
                performance = "<span color='#B37F34'><small></small></span>";
                balanced = "<span><small> </small></span>";
                power-saver = "<span color='#a6e3a1'><small></small></span>";
              };
            };
            "custom/hyprshade" = {
              format = "{}";
              tooltip = true;
              signal = 11;
              exec = "toggle-hyprshade status";
              on-click = "toggle-hyprshade";
              return-type = "json";
            };
            "custom/weather" = {
              format = "{}";
              tooltip = true;
              interval = 3600;
              exec = "wttrbar --custom-indicator '{ICON}\n<b>{temp_C}</b>' --location noida";
              return-type = "json";
            };
            "custom/updates" = {
              format = "{}";
              interval = 10800;
              exec = "~/.config/waybar/bin/updatecheck";
              return-type = "json";
              exec-if = "exit 0";
              signal = 8;
            };
            "custom/vpn" = {
              format = "{} ";
              exec = "~/.config/waybar/bin/vpn";
              return-type = "json";
              interval = 5;
            };
            "custom/hotspot" = {
              format = "{} ";
              exec = "~/.config/waybar/bin/hotspot";
              return-type = "json";
              on-click = "hash wihotspot && wihotspot";
              interval = 5;
            };
            "custom/mark" = {
              format = "";
              tooltip = false;
            };
            "custom/colorpicker" = {
              format = "{}";
              return-type = "json";
              interval = "once";
              exec = "colorpicker -j";
              on-click = "sleep 1 && colorpicker";
              signal = 1;
            };
            "custom/hyprkill" = {
              format = "{}";
              interval = "once";
              exec = "echo '󰅙\nKill clients using hyrpctl kill'";
              on-click = "sleep 1 && hyprctl kill";
            };
            "custom/notifications" = {
              format = "<b>{}</b> ";
              exec = "noti-cycle -j";
              on-click = "noti-cycle";
              on-click-right = "noti-cycle rofi";
              return-type = "json";
              interval = "once";
              signal = 2;
            };
            "custom/github" = {
              format = "{}";
              return-type = "json";
              interval = 3600;
              signal = 9;
              exec = "$HOME/.config/waybar/bin/github.sh";
              on-click = "xdg-open https =//github.com/notifications;pkill -RTMIN+9 waybar";
            };
            "idle_inhibitor" = {
              format = "{icon}";
              tooltip-format-activated = "Idle Inhibitor is active";
              tooltip-format-deactivated = "Idle Inhibitor is not active";
              format-icons = {
                activated = "󰔡";
                deactivated = "󰔢";
              };
            };
          };
        };

        style = ''
          :root { 
            --background: @base00;
            --foreground: @base03;
            --active: @base05;
          }

          * {
            font-size: 16px;
            font-family: "JetBrainsMono Nerd Font,JetBrainsMono NF";
            min-width: 8px;
            min-height: 0px;
            border: none;
            border-radius: 0;
            box-shadow: none;
            text-shadow: none;
            padding: 0px;
            }

            window#waybar {
            transition-property: background-color;
            transition-duration: 0.5s;
            border-radius: 8px;
            border: 2px solid var(--active);
            background: var(--background);
            background: alpha(var(--background), 0.7);
            color: lighter(var(--active));
            }

            menu,
            tooltip {
            border-radius: 8px;
            padding: 2px;
            border: 1px solid lighter(var(--background));
            background: alpha(var(--background), 0.6);

            color: lighter(var(--active));
            }

            menu label,
            tooltip label {
            font-size: 14px;
            color: lighter(var(--active));
            }

            #submap,
            #tray>.needs-attention {
            animation-name: blink-active;
            animation-duration: 1s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
            }

            .modules-right {
            margin: 0px 6px 6px 6px;
            border-radius: 4px;
            background: alpha(var(--background), 0.4);
            color: lighter(var(--active));
            }

            .modules-left {
            transition-property: background-color;
            transition-duration: 0.5s;
            margin: 6px 6px 6px 6px;
            border-radius: 4px;
            background: alpha(var(--background), 0.4);
            color: lighter(var(--active));
            }

            #gcpu,
            #custom-github,
            #memory,
            #disk,
            #together,
            #submap,
            #custom-weather,
            #custom-recorder,
            #connection,
            #cnoti,
            #brightness,
            #power,
            #custom-updates,
            #tray,
            #audio,
            #privacy,
            #sound {
            border-radius: 4px;
            margin: 2px 2px 4px 2px;
            background: alpha(darker(var(--active)), 0.3);
            }

            #custom-notifications {
            padding-left: 4px;
            }

            #custom-hotspot,
            #custom-github,
            #custom-notifications {
            font-size: 14px;
            }

            #custom-hotspot {
            padding-right: 2px;
            }

            #custom-vpn,
            #custom-hotspot {
            background: alpha(darker(var(--active)), 0.3);
            }

            #privacy-item {
            padding: 6px 0px 6px 6px;
            }

            #gcpu {
            padding: 8px 0px 8px 0px;
            }

            #custom-cpu-icon {
            font-size: 25px;
            }

            #custom-cputemp,
            #disk,
            #memory,
            #cpu {
            font-size: 14px;
            font-weight: bold;
            }

            #custom-github {
            padding-top: 2px;
            padding-right: 4px;
            }

            #custom-dmark {
            color: alpha(var(--foreground), 0.3);
            }

            #submap {
            margin-bottom: 0px;
            }

            #workspaces {
            margin: 0px 2px;
            padding: 4px 0px 0px 0px;
            border-radius: 8px;
            }

            #workspaces button {
            transition-property: background-color;
            transition-duration: 0.5s;
            color: var(--foreground);
            background: transparent;
            border-radius: 4px;
            color: alpha(var(--foreground), 0.3);
            }

            #workspaces button.urgent {
            font-weight: bold;
            color: var(--foreground);
            }

            #workspaces button.active {
            padding: 4px 2px;
            background: alpha(var(--active), 0.4);
            color: lighter(var(--active));
            border-radius: 4px;
            }

            #network.wifi {
            padding-right: 4px;
            }

            #submap {
            min-width: 0px;
            margin: 4px 6px 4px 6px;
            }

            #custom-weather,
            #tray {
            padding: 4px 0px 4px 0px;
            }

            #bluetooth {
            padding-top: 2px;
            }

            #battery {
            border-radius: 8px;
            padding: 4px 0px;
            margin: 4px 2px 4px 2px;
            }

            #battery.discharging.warning {
            animation-name: blink-yellow;
            animation-duration: 1s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
            }

            #battery.discharging.critical {
            animation-name: blink-red;
            animation-duration: 1s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
            }

            #clock {
            font-weight: bold;
            padding: 4px 2px 2px 2px;
            }

            #pulseaudio.mic {
            border-radius: 4px;
            color: @background;
            background: alpha(darker(var(--foreground)), 0.6);
            padding-left: 4px;
            }

            #backlight-slider slider,
            #pulseaudio-slider slider {
            background-color: transparent;
            box-shadow: none;
            }

            #backlight-slider trough,
            #pulseaudio-slider trough {
            margin-top: 4px;
            min-width: 6px;
            min-height: 60px;
            border-radius: 8px;
            background-color: alpha(var(--background), 0.6);
            }

            #backlight-slider highlight,
            #pulseaudio-slider highlight {
            border-radius: 8px;
            background-color: lighter(var(--active));
            }

            #bluetooth.discoverable,
            #bluetooth.discovering,
            #bluetooth.pairable {
            border-radius: 8px;
            animation-name: blink-active;
            animation-duration: 1s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
            }

            @keyframes blink-active {
            to {
            background-color: var(--active);
            color: var(--foreground);
            }
            }

            @keyframes blink-red {
            to {
            background-color: #c64d4f;
            color: var(--foreground);
            }
            }

            @keyframes blink-yellow {
            to {
            background-color: #cf9022;
            color: var(--foreground);
            }
            }
        '';

      };

    })

  ]);

}
