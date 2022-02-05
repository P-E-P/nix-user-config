{ pkgs, ... }:
{
  my.programs.packageBundles.devCpp = with pkgs; [
    boost gcc
  ];
}

