{
  inputs,
  lib,
  system ? "x86_64-linux",
  ...
}:
let
  repo_url = "https://raw.githubusercontent.com/keithbutler-wit/nixos";
  mkIso =
    nixpkgs: isoPath:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/${isoPath}.nix"
        (
          { pkgs, ... }:
          {
            environment = {
              systemPackages =
                [
                  (pkgs.writeShellApplication {
                    name = "os-install";
                    runtimeInputs = [ pkgs.curl ];
                    text = "sh <(curl -L ${repo_url}/main/install.sh)";
                  })
                  (pkgs.writeShellApplication {
                    name = "os-recover";
                    runtimeInputs = [ pkgs.curl ];
                    text = "sh <(curl -L ${repo_url}/main/recover.sh)";
                  })
                  (pkgs.writeShellApplication {
                    name = "os-reinstall";
                    runtimeInputs = [ pkgs.curl ];
                    text = "sh <(curl -L ${repo_url}/main/recover.sh)";
                  })
                ]
                ++ (with pkgs; [
                  btop
                  git
                  eza
                  yazi
                ]);
              shellAliases = {
                eza = "eza '--icons' '--group-directories-first' '--header' '--octal-permissions' '--hyperlink'";
                ls = "eza";
                ll = "eza -l";
                la = "eza -a";
                lla = "eza -la";
                t = "eza -la --git-ignore --icons --tree --hyperlink --level 3";
                tree = "eza -la --git-ignore --icons --tree --hyperlink --level 3";
                y = "yazi";
              };
            };

            programs = {
              # bye bye nano
              nano.enable = false;
              neovim = {
                enable = true;
                defaultEditor = true;
              };
            };

            # enable SSH in the boot process.
            systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

            # quality of life
            nix = {
              package = pkgs.nixVersions.latest;
              settings = {
                experimental-features = [
                  "nix-command"
                  "flakes"
                ];
                substituters = [
                  "https://hyprland.cachix.org"
                  "https://nix-community.cachix.org"
                  "https://ghostty.cachix.org"
                ];
                trusted-public-keys = [
                  "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                  "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
                ];
              };
            };
          }
        )
      ];
    };
in
{
  # kde-iso = mkIso inputs.nixpkgs-stable "installation-cd-graphical-calamares-plasma5";
  # minimal-iso = mkIso inputs.nixpkgs-stable "installation-cd-minimal";
  # kde-iso-unstable = mkIso inputs.nixpkgs "installation-cd-graphical-calamares-plasma5";
  minimal-iso-unstable = mkIso inputs.nixpkgs "installation-cd-minimal";
}
