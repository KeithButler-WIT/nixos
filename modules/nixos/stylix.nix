{ pkgs, config, lib, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.stylix;
in {

  options.modules.stylix.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      image = ../home-manager/hyprland/wallpaper.jpg;
      fonts = {
        monospace = {
          name = "jetbrains mono nerd font";
          package = pkgs.jetbrains-mono;
        };
        # sansSerif = {
        #   name = "jetbrains mono nerd font";
        #   package = pkgs.jetbrains-mono;
        # };
        # emoji = {
        #   name = "jetbrains mono nerd font";
        #   package = pkgs.jetbrains-mono;
        # };
      };
      cursor = {
        name = "Nordzy-cursors";
        package = pkgs.nordzy-cursor-theme;
        size = 24;
      };
      polarity = "dark";
      opacity = {
        applications = 0.95;
        desktop = 0.95;
        popups = 0.95;
        terminal = 0.95;
      };
      targets = {
        grub.useImage = true;
      };
    };
  };

}
