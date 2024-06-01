# Keith's NixOS Config

[![Made with Doom Emacs](https://img.shields.io/badge/Made_with-Doom_Emacs-blueviolet.svg?style=flat-square&logo=GNU%20Emacs&logoColor=white)](https://github.com/hlissner/doom-emacs)
[![NixOS Unstable](https://img.shields.io/badge/NixOS-unstable-blue.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)

|                |                                                          |
|----------------|----------------------------------------------------------|
| **Shell:**     | fish |
| **DM:**        | greetd + tuigreetd |
| **WM:**        | Hyprland + waybar |
| **Editor:**    | [Doom Emacs][doom-emacs] |
| **Terminal:**  | kitty |
| **Launcher:**  | rofi |
| **Browser:**   | floorp |
| **GTK Theme:** | [Ant Dracula](https://github.com/EliverLara/Ant-Dracula) |

## Quick Start

### Nixos

1. Getting:

```sh
    sh <(curl -L https://raw.githubusercontent.com/keithbutler-wit/nixos/main/install.sh)
```

1. Building

```sh
    sudo nixos-rebuild switch --flake 'github:keithbutler-wit/nixos#nixos'
```

### Non-Nixos

```sh
git clone https://github.com/keithbutler-wit/nixos
```

### Build-Ios

```sh
nix build ".#nixosConfigurations.minimal-iso-unstable.config.system.build.isoImage"
```

## Source

<https://github.com/iynaix/dotfiles>

## TODO

* Enable firewall

[doom-emacs]: https://github.com/hlissner/doom-emacs
