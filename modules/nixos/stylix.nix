{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.my;
let
  cfg = config.modules.stylix;
in
{
  options.modules.stylix.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      image = ../../wallpaper.jpg;
      fonts = {
        monospace = {
          name = "JetBrainsMono Nerd Font Mono";
          package = pkgs.nerd-fonts.jetbrains-mono;
        };
        sansSerif = {
          name = "DejaVu Sans";
          package = pkgs.dejavu_fonts;
        };
        serif = {
          name = "DejaVu Serif";
          package = pkgs.dejavu_fonts;
        };
        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-color-emoji;
          #name = "Nerd Fonts Symbols Only";
          #package = pkgs.nerd-fonts.symbols-only;
        };
        # sizes = {
        #   applications = 12;
        #   terminal = 15;
        #   desktop = 10;
        #   popups = 10;
        # };
      };
      cursor = {
        name = "Nordzy-cursors";
        package = pkgs.nordzy-cursor-theme;
        size = 24;
      };
      opacity = {
        applications = 0.95;
        desktop = 0.95;
        popups = 0.95;
        terminal = 0.95;
      };
      targets = {
        grub.useImage = true;
      };
      polarity = "dark";
    };
  };
}
