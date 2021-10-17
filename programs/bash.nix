{ ... }:

{
  enable = true;
  historyControl = [ "ignorespace" ];
  historyIgnore = [ "exit" ];

  shellAliases = import bash/aliases.nix {};

  initExtra = ''
          set -o vi
  '';
}
