{ config, lib, pkgs, ... }:

{

    # TODO Addd hyprland conf

    home.packages = [
      (pkgs.python3Packages.buildPythonPackage rec {
        pname = "pyprland";
        version = "1.4.1";
        src = pkgs.fetchPypi {
            inherit pname version;
            sha256 = "sha256-JRxUn4uibkl9tyOe68YuHuJKwtJS//Pmi16el5gL9n8=";
        };
        format = "pyproject";
        propagatedBuildInputs = with pkgs; [
            python3Packages.setuptools
            python3Packages.poetry-core
            poetry
        ];
        doCheck = false;
        })

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
