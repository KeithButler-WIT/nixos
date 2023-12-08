{ config, lib, pkgs, ... }:

{
  # Was used to get emacs-git
  # nixpkgs.overlays = [
    # (import (builtins.fetchTarball {
    #   url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    # }))
  # ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
    extraPackages =
      (epkgs: [
        epkgs.vterm epkgs.lsp-pyright epkgs.pdf-tools

        # Doom Emacs Deps
        pkgs.libpng
        pkgs.zlib
        pkgs.poppler_gi
        pkgs.ripgrep
        pkgs.fd
        pkgs.aspell
        pkgs.aspellDicts.en
        pkgs.imagemagick
        pkgs.librsvg
      ] );
  };

  home.file.".config/doom".source = ./doom;

  # https://nixos.wiki/wiki/Emacs
  # services.emacs.enable = true;
  # services.emacs.client.enable = true;
}
