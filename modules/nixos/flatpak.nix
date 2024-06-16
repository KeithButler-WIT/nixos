{ pkgs, config, lib, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.flatpak;
in {

  options.modules.flatpak.enable =
    mkBoolOpt false;

  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  config = lib.mkIf cfg.enable {

    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
    services.flatpak = {
      enable = true;
      packages = [
        "com.github.tchx84.Flatseal"
        "com.unity.UnityHub"
        # "com.valvesoftware.Steam" # Steam works better as flatpak
        # "com.valvesoftware.Steam.CompatibilityTool.Boxtron"
        # "com.valvesoftware.Steam.CompatibilityTool.Proton-GE"
        # "com.valvesoftware.Steam.Utility.gamescope"
        # "com.valvesoftware.Steam.Utility.protontricks"
        # "com.valvesoftware.SteamLink"
        # "org.freedesktop.Platform.VulkanLayer.MangoHud"
      ];
      # update.onActivation = true;
      update.auto = {
        enable = true;
        onCalendar = "weekly"; # Default value
      };
      # uninstallUnmanaged = true;
      overrides = {
        global = {
          # Force Wayland by default
          Context.sockets = [ "wayland" "!x11" "!fallback-x11" ];

          Environment = {
            # Fix un-themed cursor in some Wayland apps
            XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

            # Force correct theme for some GTK apps
            GTK_THEME = "Adwaita:dark";
          };
        };
      };
    };
  };

}
