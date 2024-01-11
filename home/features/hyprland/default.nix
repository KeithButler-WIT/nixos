{ config, lib, pkgs, ... }:

{

    # TODO Addd hyprland conf

  home.packages = [
    pkgs.pyprland
    pkgs.grimblast
    pkgs.waybar
    pkgs.nwg-bar
    pkgs.nwg-drawer
    pkgs.nwg-launchers
    pkgs.nwg-look
  ];

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

  programs.wpaperd = {
      enable = true;
      settings = {
        default = {
            path = "/home/keith/Pictures/Wallpapers";
            duration = "1h";
        };
      };
  };

}
