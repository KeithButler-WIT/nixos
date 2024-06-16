default:
	@just --list

make-iso:
	nix build ".#nixosConfigurations.minimal-iso-unstable.config.system.build.isoImage

rebuild:
	git add --all
	nh os switch
