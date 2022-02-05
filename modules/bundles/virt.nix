{ pkgs, ... }:
{
  my.programs.packageBundles.virt = with pkgs; [
        qemu
        virt-viewer virt-manager
  ];
}

