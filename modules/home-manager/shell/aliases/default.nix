{ config, lib, pkgs, ... }:

{

  home.shellAliases = {
    # Replace ls with exa
    ls = "${pkgs.eza}/bin/eza -al --color=always --group-directories-first --icons"; # preferred listing
    la = "${pkgs.eza}/bin/eza -a --color=always --group-directories-first --icons"; # all files and dirs
    ll = "${pkgs.eza}/bin/eza -l --color=always --group-directories-first --icons"; # long format
    lt = "${pkgs.eza}/bin/eza -aT --color=always --group-directories-first --icons"; # tree listing
    "l." = "${pkgs.eza}/bin/eza -a | grep -E '^\.'"; # show only dotfiles
    ip = "ip -color";

    # Replace some more things with better alternatives
    cat = "${pkgs.bat}/bin/bat --style header --style snip --style changes --style header";
    #cd = "z";
    #cdi = "zi";

    # Common use
    tarnow = "tar -acf ";
    untar = "tar -xvf ";
    wget = "${pkgs.wget}/bin/wget -c ";
    psmem = "ps auxf | sort -nr -k 4";
    psmem10 = "ps auxf | sort -nr -k 4 | head -10";
    cl = "clear";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "......" = "cd ../../../../..";
    dir = "dir --color=auto";
    vdir = "vdir --color=auto";
    grep = "grep --color=auto";
    fgrep = "fgrep --color=auto";
    egrep = "egrep --color=auto";
    hw = "hwinfo --short"; # Hardware Info
    big = "expac -H M '%m\t%n' | sort -h | nl"; # Sort installed packages according to size in MB
    #gitpkg="pacman -Q | grep -i '\-git' | wc -l"; # List amount of -git packages
    hm = "home-manager";
    hms = "home-manager --flake ~/nixos/home/ switch --impure";
    upd = "sudo nixos-rebuild --flake ~/nixos#nixos switch";
    g = "git";

    # Get fastest mirrors
    mirror = "sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist";
    mirrord = "sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist";
    mirrors = "sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist";
    mirrora = "sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist";

    # Cleanup orphaned packages
    # cleanup="sudo pacman -Rns (pacman -Qtdq)";
    nix-clean = "home-manager expire-generations 10 days; sudo nix-store --optimize; sudo nix-store --gc; sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/ * && nix-collect-garbage && nix-collect-garbage -d";

    # Get the error messages from journalctl
    jctl = "journalctl -p 3 -xb";

    music = "LD_PRELOAD=/usr/local/lib/spotify-adblock.so ${pkgs.spotify}/bin/spotify $argv";
  };

}
