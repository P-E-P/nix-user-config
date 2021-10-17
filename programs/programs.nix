{ pkgs, ... }:

{
  home-manager.enable = true;
  command-not-found.enable = true;

  vim = import ./vim.nix { inherit pkgs; };

  git = {
    enable = true;
    userName = "Pierre-Emmanuel Patry";
    userEmail = "pierre-emmanuel.patry" + "@" + "epita.fr";
    aliases = {
      lg = "log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
    ignores = [ "*~" "*.swp" ".o" ".d" "format_marker"];
  };

  bash = {
    enable = true;
    historyControl = [ "ignorespace" ];
    historyIgnore = [ "exit" ];

    shellAliases = {
      fmt = ''
            find \$(test -f format_marker && echo -newer format_marker) \( -name '*.cc' -o -name '*.hh' -o -name '*.[ch]' \) -exec clang-format -i -style=file \{\} \; && touch format_marker
      '';
    };

    initExtra = ''
          set -o vi
    '';
  };

  rofi = {
    enable = true;
  };

}
