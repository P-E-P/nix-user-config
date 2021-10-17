{ ... }:

{
  enable = true;
  historyControl = [ "ignorespace" ];
  historyIgnore = [ "exit" ];

  shellAliases = import bash/aliases.nix {};

  initExtra = builtins.readFile bash/init.bash;
}
