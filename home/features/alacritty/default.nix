{ pkgs, lib, config, ... }:

{

  # requires extra setup on non-Nixos
  # https://nixos.org/manual/nixpkgs/unstable/#nix-on-gnulinux
  programs.alacritty = {
    enable = true;

    # extraPackages = with pkgs; [
    #   mcfly
    # ];

    settings = {
      window = {
        opacity = 0.6;
        dynamic_padding = true;
        decoration = "full";
        title = "Alacritty@Garuda";
        class = {
          instance = "Alacritty";
          general = "Alacritty";
        };
        window.decorations_theme_variant = "dark";
      };

      scrolling = {
        history = 100000;
        multiplier = 3;
      };

      font = {
        size = 12;
        normal.family = "FantasqueSansMono";
        bold.family = "FantasqueSansMono";
        italic.family = "FantasqueSansMono";
        bold_italic.family = "FantasqueSansMono";
        bold_italic.size = 10.0;
      };

      draw_bold_text_with_bright_colors = true;

      save_to_clipboard = true;
      window.dynamic_title = true;
      cursor.style = "Underline";
      live_config_reload = true;
      shell.program = "/usr/bin/fish";
      mouse.hide_when_typing = true;


      colors = with config.colorScheme.colors; {
        bright = {
          black = "0x${base00}";
          blue = "0x${base0D}";
          cyan = "0x${base0C}";
          green = "0x${base0B}";
          magenta = "0x${base0E}";
          red = "0x${base08}";
          white = "0x${base06}";
          yellow = "0x${base09}";
        };
        cursor = {
          cursor = "0x${base06}";
          text = "0x${base06}";
        };
        normal = {
          black = "0x${base00}";
          blue = "0x${base0D}";
          cyan = "0x${base0C}";
          green = "0x${base0B}";
          magenta = "0x${base0E}";
          red = "0x${base08}";
          white = "0x${base06}";
          yellow = "0x${base0A}";
        };
        primary = {
          background = "0x${base00}";
          foreground = "0x${base06}";
        };
      };

      # key_bindings = {
        # (Windows, Linux, and BSD only)
        # { key = V; mods = Control|Shift; action = Paste };
        # { key = C; mods = Control|Shift; action = Copy };
        # { key = Insert; mods = Shift; action = PasteSelection };
        # { key = Key0; mods = Control; action = ResetFontSize };
        # { key = Equals; mods = Control; action = IncreaseFontSize };
        # { key = Plus; mods = Control; action = IncreaseFontSize };
        # { key = Minus; mods = Control; action = DecreaseFontSize };
        # { key = Minus; mods = Control; action = DecreaseFontSize };
      # };
    };
  };
}
