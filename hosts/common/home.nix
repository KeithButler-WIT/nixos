{
  pkgs,
  inputs,
  userSettings,
  ...
}:
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    # inputs.nixvim.homeManagerModules.nixvim
  ];

  #nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #targets.genericLinux.enable = true; # Enable this on non nixos

  nix = {
    # package = pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ userSettings.username ];
      trusted-substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
        "https://ghostty.cachix.org"
        "https://yazi.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      ];
      # substituters = [ "https://cache.nixos.org" "https://tomodachi94.cachix.org" ];
      # trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "tomodachi94.cachix.org-1:E1WFk+SYPtq3FFO+NvDgsyciIHg8nHxB/z7qNfojxpI=" ];
    };
  };

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";
  home = {
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.05"; # Please read the comment before changing.
  };

  home.packages = with pkgs; [
    # (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "SourceCodePro" "FantasqueSansMono" "FiraCode" "OpenDyslexic" "JetBrainsMono" "Hack" ]; })
    #nerd-fonts.jetbrains-mono
    #nerd-fonts.symbols-only
    fira-code-symbols
    corefonts
    noto-fonts
    roboto
    lato
    font-awesome

    xdragon
    yt-dlp

    nix-index
    inputs.nix-alien.packages.${system}.nix-alien
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
