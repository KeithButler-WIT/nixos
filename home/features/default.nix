{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    ./file
    ./gui
    ./tui
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # TODO add to direnv in required projects

    nixpkgs-fmt
    shfmt

    egl-wayland
    # pkgs.python311
    (python311.withPackages (ps: with ps; [ types-beautifulsoup4 beautifulsoup4 ]))

    toybox

    # TODO: Move into a flake in required folders
    # (pkgs.python310.withPackages (ps: with ps; [ pytz numpy types-beautifulsoup4 beautifulsoup4 requests black pyside6 pylint pillow pywlroots pyflakes poetry-core ]))

    fira-code-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "SourceCodePro" "FantasqueSansMono" "FiraCode" "OpenDyslexic" "JetBrainsMono" "Hack" ]; })
    corefonts
    noto-fonts

    v4l-utils

    termusic

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # TODO: move into nh module
    nh
    nix-output-monitor
    nvd
  ];


}
