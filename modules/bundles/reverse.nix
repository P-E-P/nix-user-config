{ pkgs, ... }:
{
  my.programs.packageBundles.reverse = with pkgs; [
    ghidra-bin radare2
  ];
}

