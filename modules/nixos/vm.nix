{ config, lib, pkgs, userSettings, ... }:

{

  options = {
    vm.enable =
      lib.mkEnableOption "enables vms";
  };

  config = lib.mkIf config.vm.enable {
    # Install necessary packages
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      gnome.adwaita-icon-theme
      quickemu
      quickgui
    ];

    programs.dconf.enable = true;
    programs.virt-manager.enable = true;
    # Manage the virtualisation services
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
    users.users.${userSettings.username}.extraGroups = [ "libvirtd" "kvm" ];
  };

}
