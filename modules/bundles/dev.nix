{ pkgs, ... }:

let
  unstable = import <nixos-unstable> { config.allowUnfree = true; };
in
  {
    my.programs.packageBundles.dev = with pkgs; [
        gcc m4 gnumake
        valgrind clang-tools
        universal-ctags
    ];
  }

