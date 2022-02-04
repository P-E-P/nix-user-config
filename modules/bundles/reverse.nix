{ pkgs, ... }:

let
  unstable = import <nixos-unstable> { config.allowUnfree = true; };
in
  {
    my.programs.packageBundles.reverse = with pkgs; [
        ghidra-bin radare2
    ];
  }

