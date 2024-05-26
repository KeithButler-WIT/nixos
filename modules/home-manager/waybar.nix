{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.waybar;
in {

  options.modules.waybar.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
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
            #"format" = " {:%a %d %b  %H:%M}";	  # 24 hour format
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
            format-icons = [
              ""
              ""
            ];
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
            # "interface" = "wlp0s20f3", // (Optional) To force the use of this interface  "format-wifi" = "  {essid}";
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
  };

}
