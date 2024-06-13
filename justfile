default:
	@just --list

make-iso:
	nix build ".#nixosConfigurations.minimal-iso-unstable.config.system.build.isoImage
