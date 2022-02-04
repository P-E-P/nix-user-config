{ pkgs, ... }:

let
  unstable = import <nixos-unstable> { config.allowUnfree = true; };
in
  {
    my.programs.packageBundles.devCpp = with pkgs; [
      boost gcc
    ];
  }

