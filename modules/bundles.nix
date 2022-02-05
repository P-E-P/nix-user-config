{ config, pkgs, lib, ...}:
{

  imports = [
    ./bundles/dev.nix
    ./bundles/devJava.nix
    ./bundles/devCpp.nix
    ./bundles/reverse.nix
    ./bundles/virt.nix
  ];
}
