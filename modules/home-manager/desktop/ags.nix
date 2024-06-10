{ pkgs, config, lib, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.ags;
in {

  options.modules.desktop.ags = {
    enable = mkBoolOpt false;
    horizontal.enable = mkBoolOpt false;
    vertical.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable (mkMerge [
    { }

    (mkIf (cfg.enable) {
      home.packages = with pkgs; [
        bun
        dart-sass
        fd
        brightnessctl
        swww
        inputs.matugen.packages.${system}.default
        slurp
        wf-recorder
        wl-clipboard
        wayshot
        swappy
        hyprpicker
        pavucontrol
        networkmanager
        gtk3
      ];

      programs.ags = {
        enable = true;

        # configDir = ../ags;

        extraPackages = with pkgs; [
          # gtksourceview
          # webkitgtk
          accountsservice
        ];
      };

    })

  ]);

}
