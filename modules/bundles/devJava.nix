{ pkgs, ... }:

let
  unstable = import <nixos-unstable> { config.allowUnfree = true; };
in
  {
    my.programs.packageBundles.devJava = with pkgs; [
      unstable.adoptopenjdk-openj9-bin-16 maven
      unstable.idea.idea-ultimate
    ];
  }

