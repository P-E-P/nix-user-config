{ pkgs, ... }:

{
  home-manager.enable = true;
  command-not-found.enable = true;

  vim = import ./vim.nix { inherit pkgs; };

  git = import ./git.nix {};

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
