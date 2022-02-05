{ pkgs, ... }:
{
  my.programs.packageBundles.dev = with pkgs; [
    gcc m4 gnumake
    valgrind clang-tools
    universal-ctags
  ];
}

