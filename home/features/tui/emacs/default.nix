{ config, lib, pkgs, inputs, ... }:

{

  imports = [ inputs.nix-doom-emacs.hmModule ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs28;
    # package = doom-emacs;
    extraPackages =
      (epkgs: [
        epkgs.vterm
        epkgs.lsp-pyright
        epkgs.pdf-tools

        # Doom Emacs Deps
        pkgs.libpng
        pkgs.gcc
        pkgs.zlib
        pkgs.poppler_gi
        pkgs.fd
        pkgs.aspell
        pkgs.aspellDicts.en
        pkgs.imagemagick
        pkgs.librsvg
        pkgs.binutils
        (pkgs.ripgrep.override { withPCRE2 = true; })
        pkgs.gnutls
        pkgs.imagemagick
        pkgs.zstd
        pkgs.nodePackages.javascript-typescript-langserver
        pkgs.sqlite
        pkgs.editorconfig-core-c
        pkgs.emacs-all-the-icons-fonts

        # org-roam Deps
        pkgs.dash
        epkgs.f
        epkgs.s
        epkgs.emacsql
        epkgs.emacsql-sqlite
        epkgs.magit-section
        epkgs.magit-filenotify
      ]);
  };

  home.file.".config/doom" = {
    source = ./doom;
    recursive = true;
  };

  # # https://github.com/vlaci/nix-doom-emacs
  # programs.doom-emacs = {
  #   enable = true;
  #   doomPrivateDir = ./doom;
  # };

  # https://nixos.wiki/wiki/Emacs
  services.emacs.enable = true;
  services.emacs.client.enable = true;
}
