{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:
with lib;
with lib.my;
let
  cfg = config.modules.vm;
in
{
  options.modules.vm.enable = mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    # Install necessary packages
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      adwaita-icon-theme
      quickemu
      quickgui
    ];

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
    users.users.${userSettings.username}.extraGroups = [
      "libvirtd"
      "kvm"
    ];
  };
}
