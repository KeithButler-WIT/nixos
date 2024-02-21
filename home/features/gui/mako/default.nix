{ pkgs, config, ... }:

{

  services.mako = with config.colorScheme.colors; {
    enable = false;
    backgroundColor = "#${base01}";
    borderColor = "#${base0E}";
    borderRadius = 5;
    borderSize = 2;
    textColor = "#${base04}";
    layer = "overlay";
  };

}
